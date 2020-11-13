```@meta
CurrentModule = Telegram
```

Word of caution: this documentation is generated automatically from [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api) and can be incomplete or wrongly formatted. Also this documentation do not contain information about general principles of the Telegram API and response objects. So, if you have any doubts, consult original [api documentation](https://core.telegram.org/bots/api) and consider it as a ground truth. These docs were generated only for simpler navigation and better help hints in REPL and editors.

Please notice that this package implements the [Bot API](https://core.telegram.org/api#bot-api). The Telegram Bot API is an API specifically for bots, which is simpler but less customisable. It acts as an intermediary between bots and the [Telegram API](https://core.telegram.org/api#telegram-api) which allow you to build your own customized Telegram clients.

All API functions have [`TelegramClient`](@ref) as optional positional argument, which means that if it is not set explicitly, than global client is used, which is usually created during initial construction or by explicit call of [`useglobally!`](@ref) function.

All arguments usually have `String`/`Boolean`/`Integer` types which is in one to one correspondence with julian types. Special arguments like `document`, `photo` and the like, which are intended for file sending, can accept either `IOStream` argument as in `open("picture.png", "r")` or `Pair{String, IO}` in case of in-memory `IO` objects without names. Read [Usage](@ref) for additional info.

# API Reference




## Getting updates

* [`Telegram.getUpdates`](@ref)
* [`Telegram.setWebhook`](@ref)
* [`Telegram.deleteWebhook`](@ref)
* [`Telegram.getWebhookInfo`](@ref)

```@docs
getUpdates
```

```@docs
setWebhook
```

```@docs
deleteWebhook
```

```@docs
getWebhookInfo
```

## Available methods

* [`Telegram.getMe`](@ref)
* [`Telegram.logOut`](@ref)
* [`Telegram.close`](@ref)
* [`Telegram.sendMessage`](@ref)
* [`Telegram.forwardMessage`](@ref)
* [`Telegram.copyMessage`](@ref)
* [`Telegram.sendPhoto`](@ref)
* [`Telegram.sendAudio`](@ref)
* [`Telegram.sendDocument`](@ref)
* [`Telegram.sendVideo`](@ref)
* [`Telegram.sendAnimation`](@ref)
* [`Telegram.sendVoice`](@ref)
* [`Telegram.sendVideoNote`](@ref)
* [`Telegram.sendMediaGroup`](@ref)
* [`Telegram.sendLocation`](@ref)
* [`Telegram.editMessageLiveLocation`](@ref)
* [`Telegram.stopMessageLiveLocation`](@ref)
* [`Telegram.sendVenue`](@ref)
* [`Telegram.sendContact`](@ref)
* [`Telegram.sendPoll`](@ref)
* [`Telegram.sendDice`](@ref)
* [`Telegram.sendChatAction`](@ref)
* [`Telegram.getUserProfilePhotos`](@ref)
* [`Telegram.getFile`](@ref)
* [`Telegram.kickChatMember`](@ref)
* [`Telegram.unbanChatMember`](@ref)
* [`Telegram.restrictChatMember`](@ref)
* [`Telegram.promoteChatMember`](@ref)
* [`Telegram.setChatAdministratorCustomTitle`](@ref)
* [`Telegram.setChatPermissions`](@ref)
* [`Telegram.exportChatInviteLink`](@ref)
* [`Telegram.setChatPhoto`](@ref)
* [`Telegram.deleteChatPhoto`](@ref)
* [`Telegram.setChatTitle`](@ref)
* [`Telegram.setChatDescription`](@ref)
* [`Telegram.pinChatMessage`](@ref)
* [`Telegram.unpinChatMessage`](@ref)
* [`Telegram.unpinAllChatMessages`](@ref)
* [`Telegram.leaveChat`](@ref)
* [`Telegram.getChat`](@ref)
* [`Telegram.getChatAdministrators`](@ref)
* [`Telegram.getChatMembersCount`](@ref)
* [`Telegram.getChatMember`](@ref)
* [`Telegram.setChatStickerSet`](@ref)
* [`Telegram.deleteChatStickerSet`](@ref)
* [`Telegram.answerCallbackQuery`](@ref)
* [`Telegram.setMyCommands`](@ref)
* [`Telegram.getMyCommands`](@ref)

```@docs
getMe
```

```@docs
logOut
```

```@docs
close
```

```@docs
sendMessage
```

```@docs
forwardMessage
```

```@docs
copyMessage
```

```@docs
sendPhoto
```

```@docs
sendAudio
```

```@docs
sendDocument
```

```@docs
sendVideo
```

```@docs
sendAnimation
```

```@docs
sendVoice
```

```@docs
sendVideoNote
```

```@docs
sendMediaGroup
```

```@docs
sendLocation
```

```@docs
editMessageLiveLocation
```

```@docs
stopMessageLiveLocation
```

```@docs
sendVenue
```

```@docs
sendContact
```

```@docs
sendPoll
```

```@docs
sendDice
```

```@docs
sendChatAction
```

```@docs
getUserProfilePhotos
```

```@docs
getFile
```

```@docs
kickChatMember
```

```@docs
unbanChatMember
```

```@docs
restrictChatMember
```

```@docs
promoteChatMember
```

```@docs
setChatAdministratorCustomTitle
```

```@docs
setChatPermissions
```

```@docs
exportChatInviteLink
```

```@docs
setChatPhoto
```

```@docs
deleteChatPhoto
```

```@docs
setChatTitle
```

```@docs
setChatDescription
```

```@docs
pinChatMessage
```

```@docs
unpinChatMessage
```

```@docs
unpinAllChatMessages
```

```@docs
leaveChat
```

```@docs
getChat
```

```@docs
getChatAdministrators
```

```@docs
getChatMembersCount
```

```@docs
getChatMember
```

```@docs
setChatStickerSet
```

```@docs
deleteChatStickerSet
```

```@docs
answerCallbackQuery
```

```@docs
setMyCommands
```

```@docs
getMyCommands
```

## Updating messages

* [`Telegram.editMessageText`](@ref)
* [`Telegram.editMessageCaption`](@ref)
* [`Telegram.editMessageMedia`](@ref)
* [`Telegram.editMessageReplyMarkup`](@ref)
* [`Telegram.stopPoll`](@ref)
* [`Telegram.deleteMessage`](@ref)

```@docs
editMessageText
```

```@docs
editMessageCaption
```

```@docs
editMessageMedia
```

```@docs
editMessageReplyMarkup
```

```@docs
stopPoll
```

```@docs
deleteMessage
```

## Stickers

* [`Telegram.sendSticker`](@ref)
* [`Telegram.getStickerSet`](@ref)
* [`Telegram.uploadStickerFile`](@ref)
* [`Telegram.createNewStickerSet`](@ref)
* [`Telegram.addStickerToSet`](@ref)
* [`Telegram.setStickerPositionInSet`](@ref)
* [`Telegram.deleteStickerFromSet`](@ref)
* [`Telegram.setStickerSetThumb`](@ref)

```@docs
sendSticker
```

```@docs
getStickerSet
```

```@docs
uploadStickerFile
```

```@docs
createNewStickerSet
```

```@docs
addStickerToSet
```

```@docs
setStickerPositionInSet
```

```@docs
deleteStickerFromSet
```

```@docs
setStickerSetThumb
```

## Inline mode

* [`Telegram.answerInlineQuery`](@ref)

```@docs
answerInlineQuery
```

## Payments

* [`Telegram.sendInvoice`](@ref)
* [`Telegram.answerShippingQuery`](@ref)
* [`Telegram.answerPreCheckoutQuery`](@ref)

```@docs
sendInvoice
```

```@docs
answerShippingQuery
```

```@docs
answerPreCheckoutQuery
```

## Telegram Passport

* [`Telegram.setPassportDataErrors`](@ref)

```@docs
setPassportDataErrors
```

## Games

* [`Telegram.sendGame`](@ref)
* [`Telegram.setGameScore`](@ref)
* [`Telegram.getGameHighScores`](@ref)

```@docs
sendGame
```

```@docs
setGameScore
```

```@docs
getGameHighScores
```