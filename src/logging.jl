struct TelegramLogger <: AbstractLogger
    tg::TelegramClient
    fmt::Function
    min_level::LogLevel
    async::Bool
    silent_errors::Bool
end

"""
    TelegramLogger(tg::TelegramClient; fmt = tg_formatter,
                   min_level = Logging.Info, async = true)

Creates logger, which output log messages to Telegram channel.

# Arguments
- `tg`: telegram client, should have valid `chat_id` which will be used for outcome messages. 
- `fmt`: function which accepts (`level`, `_module`, `group`, `id`, `file`, `line`) arguments and outputs message prefix. More details can be found in [Logging](https://docs.julialang.org/en/v1/stdlib/Logging/#Logging.handle_message) module. By default each messages is prepended with uppercase level, e.g. "INFO: " and the like.
- `min_level`: minimum level of log messages which is going to be processed.
- `async`: send messages in `sync` or `async` mode. Since telegram messages can take some time to be send, it make sense to set this parameter to `true`, so messages is send in the background with little impact on main program. But since in one run scripts main julia process can be finished before async message is sent, it make sense to set this parameter to `false`
- `silent_errors`: by default, if there was an error during sending a message, it will be printed in `stderr` channel. If you want to silence this output, set `silent_errors` to `true`.
"""
function TelegramLogger(tg::TelegramClient; fmt = tg_formatter, min_level = Info, async = true, silent_errors = false)
    return TelegramLogger(tg, fmt, min_level, async, silent_errors)
end

function tg_formatter(level, _module, group, id, file, line)
   return uppercase(string(level)) * ": " 
end

function handle_message(tglogger::TelegramLogger, level, message, _module, group, id,
                        filepath, line; kwargs...)
    iob = IOBuffer()

    prefix = tg_formatter(level, _module, group, id, filepath, line)
    print(iob, prefix, string(message))
    for (key, val) in kwargs
        print(iob, key, " = ", val)
    end
    text = String(take!(iob))
    if tglogger.async
        @async try
            sendMessage(tglogger.tg; text = text)
        catch err
            tglogger.silent_errors || error(err)
        end
    else
        try
            sendMessage(tglogger.tg; text = text)
        catch err
            tglogger.silent_errors || error(err)
        end
    end
end

shouldlog(tglogger::TelegramLogger, arg...) = true
min_enabled_level(tglogger::TelegramLogger) = tglogger.min_level
