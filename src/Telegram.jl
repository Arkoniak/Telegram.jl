module Telegram
using HTTP
using JSON3

export TelegramClient
export getMe, sendMessage

const DEFAULT_OPTS = Dict(:chat_id => "",
                          :parse_mode => "MarkdownV2",
                         )

mutable struct TelegramClient
    token::String
    chat_id::String
    parse_mode::String

    function TelegramClient(token; kwargs...)
        c = new()
        c.token = token
        for (k, v) in DEFAULT_OPTS
            setfield!(c, k, get(kwargs, k, v))
        end
        return c
    end
end

token(client::TelegramClient) = client.token

function query(client::TelegramClient, method; params = Dict())
    req_uri = "https://api.telegram.org/bot" * token(client) * "/" * method
    headers = ["Content-Type" => "application/json"]
    json_params = JSON3.write(params)
    JSON3.read(String(HTTP.post(req_uri, headers, json_params).body))
end

getMe(client::TelegramClient) = query(client, "getMe")

function sendMessage(client::TelegramClient; kwargs...)
    sendMessage(client, Dict(kwargs))
end

function sendMessage(client::TelegramClient, params)
    params[:chat_id] = get(params, :chat_id, client.chat_id)
    if isempty(params[:chat_id])
        throw(error("chat_id is not defined"))
    end

    params[:parse_mode] = get(params, :parse_mode, client.parse_mode)

    query(client, "sendMessage", params = params)
end

end # module
