module API
using ..Telegram

include("telegram_api.jl")

for (f, fdoc) in TELEGRAM_API
    fs=string(f)
    @eval begin
        function $f(client::Telegram.TelegramClient = Telegram.DEFAULT_OPTS.client; kwargs...)
            params = Dict{Symbol, Any}(kwargs)
            params[:chat_id] = get(params, :chat_id, Telegram.chatid(client))
            params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
            Telegram.query(client, $fs, params = params) # interpolation string directly, much faster
        end

        @doc $fdoc $f
        export $f
    end
end

end # module
