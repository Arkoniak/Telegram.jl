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
    json_params = replace(json_params, "." => "\\.")
    json_params = replace(json_params, "!" => "\\!")
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

# Methods which is checking only existence of chat_id
for method in [:kickChatMember, :unbanChatMember, :restrictChatMember,
               :promoteChatMember, :setChatAdministratorCustomTitle, :setChatPermissions,
               :exportChatInviteLink, :deleteChatPhoto, :setChatTitle,
               :setChatDescription, :pinChatMessage, :unpinChatMessage,
               :leaveChat, :getChat, :getChatAdministrators,
               :getChatMembersCount, :getChatMember,
               :setChatStickerSet, :deleteChatStickerSet]

    @eval function $method(client::TelegramClient; kwargs...)
        params = Dict{Symbol, Any}(kwargs)
        params[:chat_id] = get(params, :chat_id, client.chat_id)
        if isempty(params[:chat_id])
            throw(error("chat_id is not defined"))
        end
        query(client, String(Symbol($method)), params = params)
    end

    @eval export $method
end

# function getChat(client::TelegramClient; kwargs...)
#     params = Dict{Symbol, Any}(kwargs)
#     params[:chat_id] = get(params, :chat_id, client.chat_id)
#     if isempty(params[:chat_id])
#         throw(error("chat_id is not defined"))
#     end
#     query(client, "getChat", params = params)
# end

# function getChatAdministrators(client::TelegramClient; kwargs...)
#     params = Dict{Symbol, Any}(kwargs)
#     params[:chat_id] = get(params, :chat_id, client.chat_id)
#     if isempty(params[:chat_id])
#         throw(error("chat_id is not defined"))
#     end
#     query(client, "getChatAdministrators", params = params)
# end

# function getChatMembersCount(client::TelegramClient; kwargs...)
#     params = Dict{Symbol, Any}(kwargs)
#     params[:chat_id] = get(params, :chat_id, client.chat_id)
#     if isempty(params[:chat_id])
#         throw(error("chat_id is not defined"))
#     end
#     query(client, "getChatMembersCount", params = params)
# end

end # module
