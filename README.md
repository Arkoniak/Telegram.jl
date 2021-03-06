# Telegram

|                                                                                                  **Documentation**                                                                                                  |                                                                                                                          **Build Status**                                                                                                                          |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|  [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Arkoniak.github.io/Telegram.jl/stable)[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Arkoniak.github.io/Telegram.jl/dev)  |   [![Build](https://github.com/Arkoniak/Telegram.jl/workflows/CI/badge.svg)](https://github.com/Arkoniak/Telegram.jl/actions)[![Coverage](https://codecov.io/gh/Arkoniak/Telegram.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Arkoniak/Telegram.jl)   |

Simple [Telegram Messaging](https://telegram.org/) SDK with logging and bot facilities. Package was built with first-class support of telegram as instant message backend for various notification and reporing systems. So, simpliest way to use this package is by doing something like this

```julia
using Telegram, Telegram.API
tg = TelegramClient("YOUR TOKEN", chat_id = "YOUR CHAT_ID")

# Some lengthy calculation
# ...

sendMessage(text  = "Calculation complete, result is $result")
```

Please refer to [documentation](https://Arkoniak.github.io/Telegram.jl/dev) to learn how to properly setup telegram credentials and use package in general. 

# Installation

Package is registered so you can install it in a usual way

```julia
julia> using Pkg
julia> Pkg.add("Telegram")
```

# Usage

## Telegram Bot API

Usage is straightforward, [Telegram Bot API methods](https://core.telegram.org/bots/api#available-methods) are in one to one correspondence with this Julia wrapper. You need to create connection and then simply call necessary methods

```julia
julia> using Telegram, Telegram.API
julia> token = "YOUR TELEGRAM BOT TOKEN"
julia> TelegramClient(token)

julia> getMe()
JSON3.Object{Array{UInt8,1},SubArray{UInt64,1,Array{UInt64,1},Tuple{UnitRange{Int64}},true}} with 7 entries:
  :id                          => 123456789
  :is_bot                      => true
  :first_name                  => "Awesome Bot"
  :username                    => "AwesomeBot"
  :can_join_groups             => true
  :can_read_all_group_messages => false
  :supports_inline_queries     => false
```

Mainly you need to set arguments, but `chat_id` can be set directly in `TelegramClient` 

```julia
julia> token = "YOUR TELEGRAM BOT TOKEN"
julia> TelegramClient(token; chat_id = "YOUR TELEGRAM BOT CHAT_ID")

julia> sendMessage(text = "Hello, world!")
```

You can send files and other `IO` objects

```julia
julia> sendPhoto(photo = open("picture.jpg", "r"))
julia> io = IOBuffer()
julia> print(io, "Hello world!")
julia> sendDocument(document = "hello.txt" => io)
```

## Logging

You can use [Telegram.jl](https://github.com/Arkoniak/Telegram.jl) together with [LoggingExtras.jl](https://github.com/oxinabox/LoggingExtras.jl) to create powerful logging with insta messaging in case of critical situations

Put your credentials in `.env`

```
# .env
TELEGRAM_BOT_TOKEN = <YOUR TELEGRAM BOT TOKEN>
TELEGRAM_BOT_CHAT_ID = <YOUR TELEGRAM CHAT ID>
```

```julia
using Telegram
using Logging, LoggingExtras
using ConfigEnv

dotenv() # populate ENV with the data from .env

tg = TelegramClient()
tg_logger = TelegramLogger(tg; async = false)
demux_logger = TeeLogger(
    MinLevelLogger(tg_logger, Logging.Error),
    ConsoleLogger()
)
global_logger(demux_logger)

@warn "It is bad"        # goes to console
@info "normal stuff"     # goes to console
@error "THE WORSE THING" # goes to console and telegram
@debug "it is chill"     # goes to console
```

## Bots

You can create bot with the `run_bot` command. Here is for example Echo bot
```
# .env
TELEGRAM_BOT_TOKEN = <YOUR TELEGRAM BOT TOKEN>
```

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

# Echo bot
run_bot() do msg
    sendMessage(text = msg.message.text, chat_id = msg.message.chat.id)
end
```
