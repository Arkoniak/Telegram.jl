module API
using ..Telegram

include("telegram_api.jl")

for (f, fdoc) in TELEGRAM_API
    @eval begin
        function $f(client::Telegram.TelegramClient = Telegram.DEFAULT_OPTS.client; kwargs...)
            params = Dict{Symbol, Any}(kwargs)
            params[:chat_id] = get(params, :chat_id, Telegram.chatid(client))
            params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
            Telegram.query(client, String(Symbol($f)), params = params)
        end

        @doc $fdoc $f
        export $f
    end
end

end # module
