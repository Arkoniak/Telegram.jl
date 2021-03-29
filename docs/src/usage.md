```@meta
CurrentModule = Telegram
```
# Usage

## Setting up telegram token and chat\_id

In all examples of this section, it is assumed for simplicity that you set telegram token and chat\_id in `TELEGRAM_BOT_TOKEN` and `TELEGRAM_BOT_CHAT_ID` environment variables correspondingly. Recommended way to do it, by using [ConfigEnv.jl](https://github.com/Arkoniak/ConfigEnv.jl). You should create file `.env`

```
# .env
TELEGRAM_BOT_TOKEN = 123456:ababababababbabababababbababaab
TELEGRAM_BOT_CHAT_ID = 1234567
```

And at the beginning of the application, populate `ENV` with the `dotenv` function. `Telegram.jl` methods will use these variables automatically. Alternatively (but less secure) you can provide `token` and `chat_id` via `TelegramClient` constructor.

In order to get token itself, you should follow [this instruction](https://core.telegram.org/bots#3-how-do-i-create-a-bot). Just talk to `BotFather` and after few simple questions you will receive the token.

Easiest way to obtain chat\_id is through running simple print bot.

```julia
using Telegram
using ConfigEnv

dotenv()

run_bot() do msg
    println(msg)
end
```

After running this script just open chat with your newly created bot and send it any message. You will receive something like this
```
{
   "update_id": 87654321,
     "message": {
                   "message_id": 6789,
                         "from": {
                                               "id": 123456789,
                                           "is_bot": false,
                                    "language_code": "en"
                                 },
                         "chat": {
                                            "id": 123456789,
                                          "type": "private"
                                 },
                         "date": 1592767594,
                         "text": "Hello"
                }
}
```

In this example, field `message.chat.id = 123456789` is necessary `chat_id` which shoud be stored in `TELEGRAM_BOT_CHAT_ID` variable.

## Initializing `TelegramClient`

If you set `ENV` variables `TELEGRAM_BOT_TOKEN` and `TELEGRAM_BOT_CHAT_ID`, then telegram client use them to run all commands. Alternatively you can initialize client by passing required token parameter.

```julia
using Telegram

tg = TelegramClient("TELEGRAM BOT TOKEN")
```

Since [Telegram.jl](https://github.com/Arkoniak/Telegram.jl) was built with the first-class support of the Telegram as a notification system, you can pass `chat_id` variable, which will be used then by default in every function related to messaging

```julia
using Telegram

tg = TelegramClient("TELEGRAM BOT TOKEN"; chat_id = "DEFAULT TELEGRAM CHAT ID")

Telegram.sendMessage(tg, text = "Hello world") # will send "Hello world" message 
                                               # to chat defined in `tg.chat_id`
```

Also, by default new `TelegramClient` is used globally in all [API Reference](@ref) related functions, so you can run commands like
```julia
using Telegram
using ConfigEnv

dotenv()

Telegram.sendMessage(text = "Hello world")
```
which will send "Hello world" message to the chat defined by `ENV["TELEGRAM_BOT_CHAT_ID"]` variable with the bot defined by `ENV["TELEGRAM_BOT_TOKEN"]` variable.

In order to override this behaviour you can set `use_globally` argument of [`TelegramClient`](@ref) function. To set previously defined client as a global, you should use [`useglobally!`](@ref).

## Using Telegram Bot API

Due to the rather large number of functions defined in [API Reference](@ref), they are hidden behind module declaration, so by default they should be prefixed with `Telegram.`

```julia
using Telegram
using ConfigEnv

dotenv()

Telegram.getMe() # returns information about bot
```

If this is inconvenient for some reason, you can either introduce new and short constant name, like this
```julia
using Telegram
using ConfigEnv
const TG = Telegram

dotenv()

TG.getMe()
```

or you can import all telegram Bot API by `using Telegram.API`, in this scenario you do not need to use any prefixes
```julia
using Telegram
using Telegram.API
using ConfigEnv

dotenv()

getMe()
```

In what follows we will use latter approach.

## Sending messages

If you set telegram client globally with `chat_id` as it is described in previous sections, then you can use message related function from [API Reference](@ref), omitting `chat_id` argument. For example, this is how you can use most basic `sendMessage` function

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

sendMessage(text = "Hello world")
```

Of course if you have more than one client or writing a bot which should communicate in multiple chats, you can add this parameters to function calls and they will override default values, for example

```
# .env
TG_TOKEN = 123456:asdasd
TG_TOKEN2 = 546789:zxczxc
TG_CHAT_ID = 1234
```

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

tg1 = TelegramClient(ENV["TG_TOKEN"]; chat_id = ENV["TG_CHAT_ID"])
tg2 = TelegramClient(ENV["TG_TOKEN2"])

sendMessage(tg1, text = "I am bot number 1", chat_id = 12345)
sendMessage(tg2, text = "I am bot number 2", chat_id = 54321)
```
will send messages from two different telegram bots to two different chats. It is useful for example, when you have telegram bot communicating with users and at the same time error logs of this bot is being sent to another chat by error reporting bot.

In addition to text messages you can also send any sort of `IO` objects: images, audio, documents and so on. For example to send picture you can do something like this

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

open("picture.jpg", "r") do io
    sendPhoto(photo = io)
end

# or if you want it quick and dirty
sendPhoto(photo = open("picture.jpg", "r"))
```

Data sending is not limited by files only, you can send memory objects as well, in this case you should give them name in the form of `Pair`
```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

io = IOBuffer()
print(io, "Hello world!")
sendDocument(document = "hello.txt" => io)
```

## Logging

You can also use [Telegram.jl](https://github.com/Arkoniak/Telegram.jl) as a logging system, for this you are provided with special [`TelegramLogger`](@ref) structure. It accepts `TelegramClient` object which must have initialized `chat_id` parameter

```julia
using Telegram
using Logging
using ConfigEnv

dotenv()

tg = TelegramClient()
tg_logger = TelegramLogger(tg; async = false)

with_logger(tg_logger) do
    @info "Hello from telegram logger!"
end
```

But even better it is used together with [LoggingExtras.jl](https://github.com/oxinabox/LoggingExtras.jl) package, which can demux log messages and send critical messages to telegram backend without interrupting normal logging flow
```julia
using Telegram
using Logging, LoggingExtras
using ConfigEnv

dotenv()

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

This way, just by adding few configuration lines, you can have unchanged logging system with telegram instant messaging if anything critically important happened.

Also, take notion of `async` argument of `TelegramLogger`. There are two modes of operating, usual and asynchronous. Second is useful if you have long running program and you do not want it to pause and send telegram message, so usual scenario is like this

```julia
while true
    try
        # do some stuff
    catch err
        @error err
        # process error
    end
end    
```

But asynchronous mode has it's drawbacks, consider this for example
```julia
try
    sqrt(:a)
catch err
    @error err
end
```
if you run this snippet (with proper logger initialization) from command line, main thread  stops before asynchronous message to telegram is sent. In such cases, it make sense to set `async = false`

## Bots

### Echo bot
With the help of [`run_bot`](@ref) method it's quite simple to set up simple telegram bots.

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

# Echo bot
run_bot() do msg
    sendMessage(text = msg.message.text, chat_id = msg.message.chat.id)
end
```

### Turtle graphics bot
In this example we build more advanced bot, which is generating [turtle graphics](http://juliagraphics.github.io/Luxor.jl/stable/turtle/) with the help of [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl) package.

In addition to previous echo bot, this can do the following

1. Generate and send images in memory, without storing them in file system
2. Generate virtual keyboard, which can be used by users to make input easier

```julia
using Telegram, Telegram.API
using ConfigEnv
using Luxor

dotenv()

"""
    draw_turtle(angles::AbstractVector)
    
Draw turtle graphics, where turtle is moving in spiral, on each step rotating
on next angle from `angles` vector. Vector `angles` is repeated cyclically.
"""
function draw_turtle(angles)
    d = Drawing(600, 400, :png)
    origin()
    background("midnightblue")

    🐢 = Turtle() # you can type the turtle emoji with \:turtle:
    Pencolor(🐢, "cyan")
    Penwidth(🐢, 1.5)
    n = 5.0
    dn = 1.0/length(angles)*0.7
    for i in 1:400
        for angle in angles
            Forward(🐢, n)
            Turn(🐢, angle)
            n += dn
        end
        HueShift(🐢)
    end
    finish()

    return d
end

"""
    build_keyboard()
    
Generates [telegram keyboard](https://core.telegram.org/bots#keyboards) in the
form of 3x3 grid of buttons.
"""
function build_keyboard()
    keyboard = Vector{Vector{String}}()
    for x in 1:3
        row = String[]
        for y in 1:3
            s = join(string.(Int.(round.(rand(rand(1:4)) * 360))), " ")
            push!(row, s)
        end
        push!(keyboard, row)
    end

    return Dict(:keyboard => keyboard, :one_time_keyboard => true)
end

run_bot() do msg
    message = get(msg, :message, nothing)
    message === nothing && return nothing
    text = get(message, :text, "")
    chat = get(message, :chat, nothing)
    chat === nothing && return nothing
    chat_id = get(chat, :id, nothing)
    chat_id === nothing && return nothing
    
    if match(r"^[0-9 \.]+$", text) !== nothing
        angles = parse.(Float64, split(text, " "))
        turtle = draw_turtle(angles)
        sendPhoto(photo = "turtle.png" => turtle.buffer, reply_markup = build_keyboard(), chat_id = chat_id)
    else
        sendMessage(text = "Unknown command, please provide turtle instructions in the form `angle1 angle2` or use keyboard", reply_markup = build_keyboard(), chat_id = chat_id, parse_mode = "MarkdownV2")
    end
end
```
