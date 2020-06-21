using UrlDownload
using Gumbo
using Cascadia
using Cascadia: matchFirst
using Underscores

parser(x) = parsehtml(String(x)).root

function getmain()
    urldownload("https://core.telegram.org/bots/api", parser = parser)
end

issmall(s) = s[1] in 'a':'z'

function process_page(page = matchFirst(sel"div#dev_page_content", getmain()))
    topic = ""
    skip = true
    res = []
    for c in children(page)
        if tag(c) == :h3
            topic = nodeText(c)
            skip = true
        elseif tag(c) == :h4
            name = nodeText(c)
            if issmall(name)
                skip = false
                methodname = name
                mthd = [:topic => topic, :name => methodname,
                        :href => "https://core.telegram.org/bots/api" * matchFirst(sel"a", c).attributes["href"],
                        :description => []]
                push!(res, mthd)
            else
                skip = true
            end
        elseif !skip
            push!(res[end][end].second, c)
        end
    end

    return Dict.(res)
end

function print_href(io, text, link, methods)
    if text in methods
        print(io, "[`", text, "`](@ref)")
    else
        print(io, "[", text, "](", "https://core.telegram.org/bots/api"*link, ")")
    end
end

function process_table(x, methods, io)
    optional = IOBuffer()
    required = IOBuffer()
    isoptional = false
    isrequired = false
    body = matchFirst(sel"tbody", x)
    for row in body.children
        cols = eachmatch(sel"td", row)
        req = nodeText(cols[3])
        if req == "Yes"
            cio = required
            isrequired = true
        elseif req == "Optional"
            cio = optional
            isoptional = true
        else
            @error "Unknown requirement type: $req"
            cio = optional
            isoptional = true
        end
        # TODO Better types
        print(cio, "- `", nodeText(cols[1]),"`: (", nodeText(cols[2]), ") ")
        html2md(cols[4], methods, cio)
        print(cio, "\n")
    end

    if isrequired
        print(io, "# Required arguments\n")
        print(io, strip(String(take!(required))))
        print(io, "\n\n")
    end

    if isoptional
        print(io, "# Optional arguments\n")
        print(io, strip(String(take!(optional))))
        print(io, "\n")
    end

    return io
end

function process_description(x::Vector, methods, io = IOBuffer())
    @_ foreach(html2md(_, methods, io), x)
    return @_ io |> String(take!(__)) |> strip
end

html2md(x::HTMLText, methods, io) = print(io, x.text)
function html2md(x, methods, io = IOBuffer())
    if tag(x) == :p
        @_ foreach(html2md(_, methods, io), x.children)
        print(io, "\n\n")
    elseif tag(x) == :a
        if x.attributes["href"][1] == '#'
            print_href(io, nodeText(x), x.attributes["href"], methods)
        else
            print(io, nodeText(x))
        end
    elseif tag(x) == :table
        process_table(x, methods, io)
    elseif tag(x) == :code
        print(io, "`", nodeText(x), "`")
    else
        @_ foreach(html2md(_, methods, io), x.children)
    end

    return io
end

function create_api(funcs, output)
    f = open(output, "w")
    println(f, "const TELEGRAM_API = [")
    methods = @_ map(_[:name], funcs)
    for m in funcs
        println(f, "(:", m[:name], ", \"\"\"")
        print(f, "\t", m[:name], "([tg::TelegramClient]; kwargs...)\n\n")
        descr = process_description(m[:description], methods)
        println(f, descr)
        println(f, "\n[Function documentation source]($(m[:href]))")
        println(f, "\"\"\"),")
    end
    print(f, "]")
    close(f)
end

const DOC_PREAMBULE = """
```@meta
CurrentModule = Telegram
```

Word of caution: this documentation is generated automatically from [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api) and can be incomplete or wrongly formatted. Also this documentation do not contain information about general principles of the Telegram API and response objects. So, if you have any doubts, consult original [api documentation](https://core.telegram.org/bots/api) and consider it as a ground truth. These docs were generated only for simpler navigation and better help hints in REPL and editors.

All API functions have [`TelegramClient`](@ref) as optional positional argument, which means that if it is not set explicitly, than global client is used, which is usually created during initial construction or by explicit call of [`useglobally!`](@ref) function.

All arguments usually have `String`/`Boolean`/`Integer` types which is in one to one correspondence with julian types. Special arguments like `document`, `photo` and the like, which are intended for file sending, can accept either `IOStream` argument as in `open("picture.png", "r")` or `Pair{String, IO}` in case of in-memory `IO` objects without names. Read [Usage](@ref) for additional info.

# API Reference
"""
function create_docs(funcs, output)
    f = open(output, "w")
    println(f, DOC_PREAMBULE)
    methods = @_ map(_[:name], funcs)
    prev_topic = ""
    io = IOBuffer()
    for m in funcs
        if prev_topic != m[:topic]
            print(f, "\n")
            print(f, strip(String(take!(io))))
            print(f, "\n\n## ", m[:topic], "\n\n")
            prev_topic = m[:topic]
            io = IOBuffer()
        end
        println(f, "* [`Telegram.", m[:name], "`](@ref)")
        println(io, "```@docs")
        println(io, m[:name])
        print(io, "```\n\n")
    end
    print(f, "\n")
    print(f, strip(String(take!(io))))
    
    close(f)
end
