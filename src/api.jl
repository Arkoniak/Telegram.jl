module API
using ..Telegram

include("telegram_api.jl")

# Methods which is checking only existence of chat_id
# for method in [:getMe, :sendMessage, 
#                :sendPhoto, :sendAudio, :sendDocument, :sendVideo, :sendAnimation, :sendVoice,
#                :sendVideoNote,
#                :kickChatMember, :unbanChatMember, :restrictChatMember,
#                :promoteChatMember, :setChatAdministratorCustomTitle, :setChatPermissions,
#                :exportChatInviteLink, :deleteChatPhoto, :setChatTitle,
#                :setChatDescription, :pinChatMessage, :unpinChatMessage,
#                :leaveChat, :getChat, :getChatAdministrators,
#                :getChatMembersCount, :getChatMember,
#                :setChatStickerSet, :deleteChatStickerSet,
#                :getUpdates]
for (f, fdoc) in TELEGRAM_API
    @eval begin
        function $f(client::Telegram.TelegramClient = Telegram.DEFAULT_OPTS.client; kwargs...)
            params = Dict{Symbol, Any}(kwargs)
            params[:chat_id] = get(params, :chat_id, client.chat_id)
            params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
            Telegram.query(client, String(Symbol($f)), params = params)
        end

        @doc $fdoc $f
        export $f
    end
end

end # module
