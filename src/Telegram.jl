module Telegram
using HTTP
using JSON3

export TelegramClient, useglobally!
export getMe, sendMessage

struct TelegramError{T} <: Exception
    msg::T
end

mutable struct TelegramClient
    token::String
    chat_id::String
    parse_mode::String
end

function TelegramClient(token; kwargs...)
    chat_id = get(kwargs, :chat_id, "")
    parse_mode = get(kwargs, :parse_mode, "")
    return TelegramClient(token, chat_id, parse_mode)
end

mutable struct TelegramOpts
    client::TelegramClient
    upload_kw::Vector{Symbol}
    timeout::Int
end

const DEFAULT_OPTS = TelegramOpts(TelegramClient("", "", ""), [:photo, :audio, :thumb, :docuemnt, :video, :animation, :voice, :video_note, :sticker, :png_sticker, :tgs_sticker, :certificate, :files], 100)

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
    req_uri = "https://api.telegram.org/bot" * token(client) * "/" * method
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

# getMe(client::TelegramClient = DEFAULT_OPTS.client) = query(client, "getMe")

# function sendMessage(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
#     sendMessage(client, Dict(kwargs))
# end

# function sendMessage(client::TelegramClient, params)
#     params[:chat_id] = get(params, :chat_id, client.chat_id)
#     if isempty(params[:chat_id])
#         throw(error("chat_id is not defined"))
#     end

#     params[:parse_mode] = get(params, :parse_mode, client.parse_mode)

#     query(client, "sendMessage", params = params)
# end

function apiquery(method, client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    params = Dict{Symbol, Any}(kwargs)
    params[:chat_id] = get(params, :chat_id, client.chat_id)
    params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
    query(client, "method", params = params)
end

# Methods which is checking only existence of chat_id
for method in [:getMe, :sendMessage, 
               :sendPhoto, :sendAudio, :sendDocument, :sendVideo, :sendAnimation, :sendVoice,
               :sendVideoNote,
               :kickChatMember, :unbanChatMember, :restrictChatMember,
               :promoteChatMember, :setChatAdministratorCustomTitle, :setChatPermissions,
               :exportChatInviteLink, :deleteChatPhoto, :setChatTitle,
               :setChatDescription, :pinChatMessage, :unpinChatMessage,
               :leaveChat, :getChat, :getChatAdministrators,
               :getChatMembersCount, :getChatMember,
               :setChatStickerSet, :deleteChatStickerSet,
               :getUpdates]

    @eval function $method(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
        params = Dict{Symbol, Any}(kwargs)
        params[:chat_id] = get(params, :chat_id, client.chat_id)
        params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
        query(client, String(Symbol($method)), params = params)
    end

    @eval export $method
end

end # module
