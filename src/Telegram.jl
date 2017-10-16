module Telegram
using Requests
using JSON

export Client
export getMe, sendMessage

mutable struct Client
  token::String
  chat_id::Nullable{String}
  
  function Client(token::String; chat_id::Nullable{String} = Nullable{String}())
    new(token, chat_id)
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
    client.chat_id = Nullable{String}(string(params[:chat_id]))
  else
    if !isnull(client.chat_id)
      params[:chat_id] = get(client.chat_id)
    else
      throw(error("chat_id is not defined"))
    end
  end
  
  query(client, "sendMessage", params = params)
end

end
