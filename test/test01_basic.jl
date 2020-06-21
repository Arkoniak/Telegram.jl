module TestBasic
using Telegram
using Telegram.API
using Test

@testset "basic api call" begin
    tg = TelegramClient("xxx"; chat_id = "yyy")
    useglobally!(tg)
    @test Telegram.DEFAULT_OPTS.client === tg
end

end # module
