struct TelegramLogger <: AbstractLogger
    tg::TelegramClient
    fmt::Function
    min_level::LogLevel
    async::Bool
end

function TelegramLogger(tg::TelegramClient; fmt = tg_formatter, min_level = Info, async = true)
    return TelegramLogger(tg, fmt, min_level, async)
end

function tg_formatter(level, _module, group, id, file, line)
   return uppercase(string(level)) * ": " 
end

function handle_message(tglogger::TelegramLogger, level, message, _module, group, id,
                        filepath, line; kwargs...)
    prefix = tg_formatter(level, _module, group, id, filepath, line)
    text = prefix * string(message)
    if tglogger.async
        @async sendMessage(tglogger.tg; text = text)
    else
        sendMessage(tglogger.tg; text = text)
    end
end

shouldlog(tglogger::TelegramLogger, arg...) = true
min_enabled_level(tglogger::TelegramLogger) = tglogger.min_level
