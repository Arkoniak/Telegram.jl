# Telegram

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Arkoniak.github.io/Telegram.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Arkoniak.github.io/Telegram.jl/dev)
[![Build Status](https://travis-ci.com/Arkoniak/Telegram.jl.svg?branch=master)](https://travis-ci.com/Arkoniak/Telegram.jl)
[![Coverage](https://codecov.io/gh/Arkoniak/Telegram.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Arkoniak/Telegram.jl)

Telegram api wrapper

# Installation

Currently package is not registered, so it should be installed from source

```julia
julia> using Pkg
julia> Pkg.add("https://github.com/Arkoniak/Telegram.jl.git")
```

# Usage

Usage is straightforward, [Telegram API methods](https://core.telegram.org/bots/api#available-methods) are in one to one correspondence with this Julia wrapper. You need to create connection and then simply call necessary methods

```julia
julia> token = "HERE SHOULD BE YOUR TOKEN"
julia> client = TelegramClient(token)

julia> getMe(client)
JSON3.Object{Base.CodeUnits{UInt8,String},Array{UInt64,1}} with 2 entries:
  :ok     => true
  :result => {…
```

You can necessary arguments in methods, but some subset can be set in `client` itself

```julia
julia> token = "HERE SHOULD BE YOUR TOKEN"
julia> client = TelegramClient(token; chat_id = "HERE SHOULD BE CHAT_ID")

julia> sendMessage(client, text = "Hello, world!")
```
or equivalently

```julia
julia> token = "HERE SHOULD BE YOUR TOKEN"
julia> client = TelegramClient(token)

julia> sendMessage(client; text = "Hello, world!", chat_id = "HERE SHOULD BE CHAT_ID")
```
