using Telegram
using Documenter

makedocs(;
    modules=[Telegram],
    authors="Andrey Oskin",
    repo="https://github.com/Arkoniak/Telegram.jl/blob/{commit}{path}#L{line}",
    sitename="Telegram.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Arkoniak.github.io/Telegram.jl",
        siteurl="https://github.com/Arkoniak/Telegram.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API Reference" => "reference.md",
        "Usage" => "usage.md",
        "Developer guide" => "developers.md"
    ],
)

deploydocs(;
    repo="github.com/Arkoniak/Telegram.jl",
)
