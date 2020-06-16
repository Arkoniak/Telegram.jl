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
