struct TelegramError{T} <: Exception
    msg::T
end

mutable struct TelegramClient
    token::String
    chat_id::String
    parse_mode::String
    ep::String
end

"""
    TelegramClient(token; chat_id, parse_mode, ep, use_globally = true)

Creates telegram client, which can be used to run telegram commands.

# Arguments
- `token::String`: telegram token, which can be obtained in telegram from @BotFather.
- `chat_id`: if set, used as default `chat_id` argument for all chat related commands. To get specific `chat_id`, send message to the bot in telegram application and use [`getUpdates`](@ref) command.
- `parse_mode`: if set, used as default for text messaging commands.
- `use_globally::Bool`: default `true`. If set to `true` then it current client can be used as default in all telegram commands.
- `ep`: endpoint for telegram api. By default `https://api.telegram.org/bot` is used, but you may change it, if you are using proxy or for testing purposes. 
"""
function TelegramClient(token; chat_id = "", parse_mode = "", ep = "https://api.telegram.org/bot", use_globally = true)
    client = TelegramClient(token, chat_id, parse_mode, ep) 
    if use_globally
        useglobally!(client)
    end
    
    return client
end

mutable struct TelegramOpts
    client::TelegramClient
    upload_kw::Vector{Symbol}
    timeout::Int
end

const DEFAULT_OPTS = TelegramOpts(TelegramClient("", "", "", ""), [:photo, :audio, :thumb, :document, :video, :animation, :voice, :video_note, :sticker, :png_sticker, :tgs_sticker, :certificate, :files], 30)

"""
    useglobally!(tg::TelegramClient)

Set `tg` as default client in all `Telegram.API` functions. 

# Example
```julia
tg = TelegramClient(ENV["TG_TOKEN"])
useglobally!(tg)

getMe() # new client is used in this command by default.
```
"""
function useglobally!(client::TelegramClient)
    DEFAULT_OPTS.client = client

    return client
end

token(client::TelegramClient) = client.token

ioify(elem::IO) = elem
ioify(elem) = IOBuffer(elem)
function ioify(elem::IOBuffer)
    seekstart(elem)
    return elem
end

pushfiles!(body, keyword, file) = push!(body, keyword => file)
function pushfiles!(body, keyword, file::Pair)
    push!(body, keyword => HTTP.Multipart(file.first, ioify(file.second)))
end

process_params(x::AbstractString) = x
process_params(x) = JSON3.write(x)   

function query(client::TelegramClient, method; params = Dict())
    req_uri = client.ep * token(client) * "/" * method
    intersection = intersect(keys(params), DEFAULT_OPTS.upload_kw)
    if isempty(intersection)
        headers = ["Content-Type" => "application/json", "Connection" => "Keep-Alive"]
        json_params = JSON3.write(params)
        res = HTTP.post(req_uri, headers, json_params; readtimeout = DEFAULT_OPTS.timeout + 1)
    else
        body = Pair[]
        for (k, v) in params
            k in intersection && continue
            push!(body, k => process_params(v))
        end
        for k in intersection
            pushfiles!(body, k, params[k])
        end
        res = HTTP.post(req_uri, ["Connection" => "Keep-Alive"], HTTP.Form(body); readtimeout = DEFAULT_OPTS.timeout + 1)
    end

    response = JSON3.read(res.body)
    
    if response.ok
        return response.result
    else
        throw(TelegramError(response))
    end
end

"""
    apiquery(method, client; kwargs...)

Sends `method` request to the telegram. It is recommended to use only if some of Telegram API function is not wrapped already.

# Arguments
- `method::String`: method name from the Telegram API, for example "getMe"
- `client::TelegramClient`: telegram client, can be omitted, in this case default client is used.
"""
function apiquery(method, client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    params = Dict{Symbol, Any}(kwargs)
    params[:chat_id] = get(params, :chat_id, client.chat_id)
    params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
    query(client, "method", params = params)
end
