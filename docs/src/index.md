```@meta
CurrentModule = Telegram
```

# Telegram
Simple [Telegram Messaging](https://telegram.org/) SDK with logging and bot facilities. Package was built with first-class support of telegram as instant message backend for various notification and reporing systems. So, simpliest way to use this package is by doing something like this

Put your credentials in `.env` file

```
# .env
TELEGRAM_BOT_TOKEN = <YOUR TELEGRAM BOT TOKEN>
TELEGRAM_BOT_CHAT_ID = <YOUR TELEGRAM CHAT ID>
```

```julia
using Telegram, Telegram.API
using ConfigEnv

dotenv()

# Some lengthy calculation
# ...

sendMessage(text  = "Calculation complete, result is $result")
```

Of course you can manually provide secrets with the `TelegramClient` constructor

```julia
tg = TelegramClient("your token"; chat_id = "your default chat_id")
sendMessage(text = "Calculation complete")
```

or even

```julia
sendMessage(tg; text = "Calculation complete")
```

## Installation
Package is registered so you can install it in a usual way

```julia
julia> using Pkg
julia> Pkg.add("Telegram")
```

## General methods

In addition to [API Reference](@ref) methods, there is a number of methods which add some julian functionality like bots and logging facilities.

```@autodocs
Modules = [Telegram]
```
