```@meta
CurrentModule = Telegram
```

# Telegram
Simple [Telegram Messaging](https://telegram.org/) SDK with logging and bot facilities. Package was built with first-class support of telegram as instant message backend for various notification and reporing systems. So, simpliest way to use this package is by doing something like this

```julia
using Telegram, Telegram.API
tg = TelegramClient("YOUR TOKEN", chat_id = "YOUR CHAT_ID")

# Some lengthy calculation
# ...

sendMessage(text  = "Calculation complete, result is $result")
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
