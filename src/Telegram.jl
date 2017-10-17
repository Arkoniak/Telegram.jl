module Telegram
using Requests
using JSON

export Client
export getMe, sendMessage

mutable struct Client
  token::String
  chat_id::Union{String, Void}
  
  function Client(token::String; chat_id = nothing)
    if !isa(chat_id, Void)
      chat_id = string(chat_id)
    end
    return new(token, chat_id)
  end
end
token(client::Client) = client.token

function query(client::Client, method::String;
               params::Dict = Dict())
  req_uri = @sprintf("https://api.telegram.org/bot%s/%s", token(client), method)
  JSON.parse(readstring(post(req_uri, data = params)))
end

function getMe(client::Client)
  query(client, "getMe")
end

function sendMessage(client::Client; kwargs...)
  sendMessage(client, Dict(kwargs))
end

function sendMessage(client::Client, params::Dict)
  if :chat_id in keys(params)
    client.chat_id = string(params[:chat_id])
  else
    if !isa(client.chat_id, Void)
      params[:chat_id] = client.chat_id
    else
      throw(error("chat_id is not defined"))
    end
  end
  
  query(client, "sendMessage", params = params)
end

end
