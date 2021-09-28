const TELEGRAM_API = [
(:getUpdates, """
	getUpdates([tg::TelegramClient]; kwargs...)

Use this method to receive incoming updates using long polling (wiki). An Array of [Update](https://core.telegram.org/bots/api#update) objects is returned.

# Optional arguments
- `offset`: (Integer) Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as [`getUpdates`](@ref) is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will forgotten.
- `limit`: (Integer) Limits the number of updates to be retrieved. Values between 1-100 are accepted. Defaults to 100.
- `timeout`: (Integer) Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.
- `allowed_updates`: (Array of String) A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See [Update](https://core.telegram.org/bots/api#update) for a complete list of available update types. Specify an empty list to receive all update types except chat_member (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the getUpdates, so unwanted updates may be received for a short period of time.
Notes1. This method will not work if an outgoing webhook is set up.2. In order to avoid getting duplicate updates, recalculate offset after each server response.

[Function documentation source](https://core.telegram.org/bots/api#getupdates)
"""),
(:setWebhook, """
	setWebhook([tg::TelegramClient]; kwargs...)

Use this method to specify a url and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified url, containing a JSON-serialized [Update](https://core.telegram.org/bots/api#update). In case of an unsuccessful request, we will give up after a reasonable amount of attempts. Returns True on success.

If you'd like to make sure that the Webhook request comes from Telegram, we recommend using a secret path in the URL, e.g. `https://www.example.com/<token>`. Since nobody else knows your bot's token, you can be pretty sure it's us.

# Required arguments
- `url`: (String) HTTPS url to send updates to. Use an empty string to remove webhook integration

# Optional arguments
- `certificate`: (InputFile) Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.
- `ip_address`: (String) The fixed IP address which will be used to send webhook requests instead of the IP address resolved through DNS
- `max_connections`: (Integer) Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot's server, and higher values to increase your bot's throughput.
- `allowed_updates`: (Array of String) A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See [Update](https://core.telegram.org/bots/api#update) for a complete list of available update types. Specify an empty list to receive all update types except chat_member (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.
- `drop_pending_updates`: (Boolean) Pass True to drop all pending updates
Notes1. You will not be able to receive updates using [`getUpdates`](@ref) for as long as an outgoing webhook is set up.2. To use a self-signed certificate, you need to upload your public key certificate using certificate parameter. Please upload as InputFile, sending a String will not work.3. Ports currently supported for Webhooks: 443, 80, 88, 8443.

NEW! If you're having any trouble setting up webhooks, please check out this amazing guide to Webhooks.

[Function documentation source](https://core.telegram.org/bots/api#setwebhook)
"""),
(:deleteWebhook, """
	deleteWebhook([tg::TelegramClient]; kwargs...)

Use this method to remove webhook integration if you decide to switch back to [`getUpdates`](@ref). Returns True on success.

# Optional arguments
- `drop_pending_updates`: (Boolean) Pass True to drop all pending updates

[Function documentation source](https://core.telegram.org/bots/api#deletewebhook)
"""),
(:getWebhookInfo, """
	getWebhookInfo([tg::TelegramClient]; kwargs...)

Use this method to get current webhook status. Requires no parameters. On success, returns a [WebhookInfo](https://core.telegram.org/bots/api#webhookinfo) object. If the bot is using [`getUpdates`](@ref), will return an object with the url field empty.

[Function documentation source](https://core.telegram.org/bots/api#getwebhookinfo)
"""),
(:getMe, """
	getMe([tg::TelegramClient]; kwargs...)

A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a [User](https://core.telegram.org/bots/api#user) object.

[Function documentation source](https://core.telegram.org/bots/api#getme)
"""),
(:logOut, """
	logOut([tg::TelegramClient]; kwargs...)

Use this method to log out from the cloud Bot API server before launching the bot locally. You must log out the bot before running it locally, otherwise there is no guarantee that the bot will receive updates. After a successful call, you can immediately log in on a local server, but will not be able to log in back to the cloud Bot API server for 10 minutes. Returns True on success. Requires no parameters.

[Function documentation source](https://core.telegram.org/bots/api#logout)
"""),
(:close, """
	close([tg::TelegramClient]; kwargs...)

Use this method to close the bot instance before moving it from one local server to another. You need to delete the webhook before calling this method to ensure that the bot isn't launched again after server restart. The method will return error 429 in the first 10 minutes after the bot is launched. Returns True on success. Requires no parameters.

[Function documentation source](https://core.telegram.org/bots/api#close)
"""),
(:sendMessage, """
	sendMessage([tg::TelegramClient]; kwargs...)

Use this method to send text messages. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `text`: (String) Text of the message to be sent, 1-4096 characters after entities parsing

# Optional arguments
- `parse_mode`: (String) Mode for parsing entities in the message text. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `entities`: (Array of MessageEntity) List of special entities that appear in message text, which can be specified instead of parse_mode
- `disable_web_page_preview`: (Boolean) Disables link previews for links in this message
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendmessage)
"""),
(:forwardMessage, """
	forwardMessage([tg::TelegramClient]; kwargs...)

Use this method to forward messages of any kind. Service messages can't be forwarded. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `from_chat_id`: (Integer or String) Unique identifier for the chat where the original message was sent (or channel username in the format `@channelusername`)
- `message_id`: (Integer) Message identifier in the chat specified in from_chat_id

# Optional arguments
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.

[Function documentation source](https://core.telegram.org/bots/api#forwardmessage)
"""),
(:copyMessage, """
	copyMessage([tg::TelegramClient]; kwargs...)

Use this method to copy messages of any kind. Service messages and invoice messages can't be copied. The method is analogous to the method [`forwardMessage`](@ref), but the copied message doesn't have a link to the original message. Returns the [MessageId](https://core.telegram.org/bots/api#messageid) of the sent message on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `from_chat_id`: (Integer or String) Unique identifier for the chat where the original message was sent (or channel username in the format `@channelusername`)
- `message_id`: (Integer) Message identifier in the chat specified in from_chat_id

# Optional arguments
- `caption`: (String) New caption for media, 0-1024 characters after entities parsing. If not specified, the original caption is kept
- `parse_mode`: (String) Mode for parsing entities in the new caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the new caption, which can be specified instead of parse_mode
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#copymessage)
"""),
(:sendPhoto, """
	sendPhoto([tg::TelegramClient]; kwargs...)

Use this method to send photos. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `photo`: (InputFile or String) Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. The photo must be at most 10 MB in size. The photo's width and height must not exceed 10000 in total. Width and height ratio must be at most 20. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `caption`: (String) Photo caption (may also be used when resending photos by file_id), 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the photo caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendphoto)
"""),
(:sendAudio, """
	sendAudio([tg::TelegramClient]; kwargs...)

Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.

For sending voice messages, use the [`sendVoice`](@ref) method instead.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `audio`: (InputFile or String) Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `caption`: (String) Audio caption, 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the audio caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `duration`: (Integer) Duration of the audio in seconds
- `performer`: (String) Performer
- `title`: (String) Track name
- `thumb`: (InputFile or String) Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendaudio)
"""),
(:sendDocument, """
	sendDocument([tg::TelegramClient]; kwargs...)

Use this method to send general files. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `document`: (InputFile or String) File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `thumb`: (InputFile or String) Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `caption`: (String) Document caption (may also be used when resending documents by file_id), 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the document caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `disable_content_type_detection`: (Boolean) Disables automatic server-side content type detection for files uploaded using multipart/form-data
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#senddocument)
"""),
(:sendVideo, """
	sendVideo([tg::TelegramClient]; kwargs...)

Use this method to send video files, Telegram clients support mp4 videos (other formats may be sent as [Document](https://core.telegram.org/bots/api#document)). On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `video`: (InputFile or String) Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `duration`: (Integer) Duration of sent video in seconds
- `width`: (Integer) Video width
- `height`: (Integer) Video height
- `thumb`: (InputFile or String) Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `caption`: (String) Video caption (may also be used when resending videos by file_id), 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the video caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `supports_streaming`: (Boolean) Pass True, if the uploaded video is suitable for streaming
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendvideo)
"""),
(:sendAnimation, """
	sendAnimation([tg::TelegramClient]; kwargs...)

Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `animation`: (InputFile or String) Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `duration`: (Integer) Duration of sent animation in seconds
- `width`: (Integer) Animation width
- `height`: (Integer) Animation height
- `thumb`: (InputFile or String) Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `caption`: (String) Animation caption (may also be used when resending animation by file_id), 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the animation caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendanimation)
"""),
(:sendVoice, """
	sendVoice([tg::TelegramClient]; kwargs...)

Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS (other formats may be sent as [Audio](https://core.telegram.org/bots/api#audio) or [Document](https://core.telegram.org/bots/api#document)). On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `voice`: (InputFile or String) Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `caption`: (String) Voice message caption, 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the voice message caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `duration`: (Integer) Duration of the voice message in seconds
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendvoice)
"""),
(:sendVideoNote, """
	sendVideoNote([tg::TelegramClient]; kwargs...)

As of v.4.0, Telegram clients support rounded square mp4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `video_note`: (InputFile or String) Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files). Sending video notes by a URL is currently unsupported

# Optional arguments
- `duration`: (Integer) Duration of sent video in seconds
- `length`: (Integer) Video width and height, i.e. diameter of the video message
- `thumb`: (InputFile or String) Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendvideonote)
"""),
(:sendMediaGroup, """
	sendMediaGroup([tg::TelegramClient]; kwargs...)

Use this method to send a group of photos, videos, documents or audios as an album. Documents and audio files can be only grouped in an album with messages of the same type. On success, an array of [Messages](https://core.telegram.org/bots/api#message) that were sent is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `media`: (Array of InputMediaAudio, InputMediaDocument, InputMediaPhoto and InputMediaVideo) A JSON-serialized array describing messages to be sent, must include 2-10 items

# Optional arguments
- `disable_notification`: (Boolean) Sends messages silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the messages are a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found

[Function documentation source](https://core.telegram.org/bots/api#sendmediagroup)
"""),
(:sendLocation, """
	sendLocation([tg::TelegramClient]; kwargs...)

Use this method to send point on the map. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `latitude`: (Float number) Latitude of the location
- `longitude`: (Float number) Longitude of the location

# Optional arguments
- `horizontal_accuracy`: (Float number) The radius of uncertainty for the location, measured in meters; 0-1500
- `live_period`: (Integer) Period in seconds for which the location will be updated (see Live Locations, should be between 60 and 86400.
- `heading`: (Integer) For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
- `proximity_alert_radius`: (Integer) For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendlocation)
"""),
(:editMessageLiveLocation, """
	editMessageLiveLocation([tg::TelegramClient]; kwargs...)

Use this method to edit live location messages. A location can be edited until its live_period expires or editing is explicitly disabled by a call to [`stopMessageLiveLocation`](@ref). On success, if the edited message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Required arguments
- `latitude`: (Float number) Latitude of new location
- `longitude`: (Float number) Longitude of new location

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message to edit
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `horizontal_accuracy`: (Float number) The radius of uncertainty for the location, measured in meters; 0-1500
- `heading`: (Integer) Direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
- `proximity_alert_radius`: (Integer) Maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#editmessagelivelocation)
"""),
(:stopMessageLiveLocation, """
	stopMessageLiveLocation([tg::TelegramClient]; kwargs...)

Use this method to stop updating a live location message before live_period expires. On success, if the message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message with live location to stop
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#stopmessagelivelocation)
"""),
(:sendVenue, """
	sendVenue([tg::TelegramClient]; kwargs...)

Use this method to send information about a venue. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `latitude`: (Float number) Latitude of the venue
- `longitude`: (Float number) Longitude of the venue
- `title`: (String) Name of the venue
- `address`: (String) Address of the venue

# Optional arguments
- `foursquare_id`: (String) Foursquare identifier of the venue
- `foursquare_type`: (String) Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
- `google_place_id`: (String) Google Places identifier of the venue
- `google_place_type`: (String) Google Places type of the venue. (See supported types.)
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendvenue)
"""),
(:sendContact, """
	sendContact([tg::TelegramClient]; kwargs...)

Use this method to send phone contacts. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `phone_number`: (String) Contact's phone number
- `first_name`: (String) Contact's first name

# Optional arguments
- `last_name`: (String) Contact's last name
- `vcard`: (String) Additional data about the contact in the form of a vCard, 0-2048 bytes
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendcontact)
"""),
(:sendPoll, """
	sendPoll([tg::TelegramClient]; kwargs...)

Use this method to send a native poll. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `question`: (String) Poll question, 1-300 characters
- `options`: (Array of String) A JSON-serialized list of answer options, 2-10 strings 1-100 characters each

# Optional arguments
- `is_anonymous`: (Boolean) True, if the poll needs to be anonymous, defaults to True
- `type`: (String) Poll type, “quiz” or “regular”, defaults to “regular”
- `allows_multiple_answers`: (Boolean) True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
- `correct_option_id`: (Integer) 0-based identifier of the correct answer option, required for polls in quiz mode
- `explanation`: (String) Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing
- `explanation_parse_mode`: (String) Mode for parsing entities in the explanation. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `explanation_entities`: (Array of MessageEntity) List of special entities that appear in the poll explanation, which can be specified instead of parse_mode
- `open_period`: (Integer) Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with close_date.
- `close_date`: (Integer) Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.
- `is_closed`: (Boolean) Pass True, if the poll needs to be immediately closed. This can be useful for poll preview.
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendpoll)
"""),
(:sendDice, """
	sendDice([tg::TelegramClient]; kwargs...)

Use this method to send an animated emoji that will display a random value. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

# Optional arguments
- `emoji`: (String) Emoji on which the dice throw animation is based. Currently, must be one of “”, “”, “”, “”, “”, or “”. Dice can have values 1-6 for “”, “” and “”, values 1-5 for “” and “”, and values 1-64 for “”. Defaults to “”
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#senddice)
"""),
(:sendChatAction, """
	sendChatAction([tg::TelegramClient]; kwargs...)

Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.

Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use [`sendChatAction`](@ref) with action = upload_photo. The user will see a “sending photo” status for the bot.

We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `action`: (String) Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for [text messages](https://core.telegram.org/bots/api#sendmessage), upload_photo for [photos](https://core.telegram.org/bots/api#sendphoto), record_video or upload_video for [videos](https://core.telegram.org/bots/api#sendvideo), record_voice or upload_voice for [voice notes](https://core.telegram.org/bots/api#sendvoice), upload_document for [general files](https://core.telegram.org/bots/api#senddocument), find_location for [location data](https://core.telegram.org/bots/api#sendlocation), record_video_note or upload_video_note for [video notes](https://core.telegram.org/bots/api#sendvideonote).

[Function documentation source](https://core.telegram.org/bots/api#sendchataction)
"""),
(:getUserProfilePhotos, """
	getUserProfilePhotos([tg::TelegramClient]; kwargs...)

Use this method to get a list of profile pictures for a user. Returns a [UserProfilePhotos](https://core.telegram.org/bots/api#userprofilephotos) object.

# Required arguments
- `user_id`: (Integer) Unique identifier of the target user

# Optional arguments
- `offset`: (Integer) Sequential number of the first photo to be returned. By default, all photos are returned.
- `limit`: (Integer) Limits the number of photos to be retrieved. Values between 1-100 are accepted. Defaults to 100.

[Function documentation source](https://core.telegram.org/bots/api#getuserprofilephotos)
"""),
(:getFile, """
	getFile([tg::TelegramClient]; kwargs...)

Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a [File](https://core.telegram.org/bots/api#file) object is returned. The file can then be downloaded via the link `https://api.telegram.org/file/bot<token>/<file_path>`, where `<file_path>` is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling [`getFile`](@ref) again.

# Required arguments
- `file_id`: (String) File identifier to get info about

Note: This function may not preserve the original file name and MIME type. You should save the file's MIME type and name (if available) when the File object is received.

[Function documentation source](https://core.telegram.org/bots/api#getfile)
"""),
(:banChatMember, """
	banChatMember([tg::TelegramClient]; kwargs...)

Use this method to ban a user in a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the chat on their own using invite links, etc., unless [unbanned](https://core.telegram.org/bots/api#unbanchatmember) first. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target group or username of the target supergroup or channel (in the format `@channelusername`)
- `user_id`: (Integer) Unique identifier of the target user

# Optional arguments
- `until_date`: (Integer) Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever. Applied for supergroups and channels only.
- `revoke_messages`: (Boolean) Pass True to delete all messages from the chat for the user that is being removed. If False, the user will be able to see messages in the group that were sent before the user was removed. Always True for supergroups and channels.

[Function documentation source](https://core.telegram.org/bots/api#banchatmember)
"""),
(:unbanChatMember, """
	unbanChatMember([tg::TelegramClient]; kwargs...)

Use this method to unban a previously banned user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. By default, this method guarantees that after the call the user is not a member of the chat, but will be able to join it. So if the user is a member of the chat they will also be removed from the chat. If you don't want this, use the parameter only_if_banned. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target group or username of the target supergroup or channel (in the format `@username`)
- `user_id`: (Integer) Unique identifier of the target user

# Optional arguments
- `only_if_banned`: (Boolean) Do nothing if the user is not banned

[Function documentation source](https://core.telegram.org/bots/api#unbanchatmember)
"""),
(:restrictChatMember, """
	restrictChatMember([tg::TelegramClient]; kwargs...)

Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate admin rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`)
- `user_id`: (Integer) Unique identifier of the target user
- `permissions`: (ChatPermissions) A JSON-serialized object for new user permissions

# Optional arguments
- `until_date`: (Integer) Date when restrictions will be lifted for the user, unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever

[Function documentation source](https://core.telegram.org/bots/api#restrictchatmember)
"""),
(:promoteChatMember, """
	promoteChatMember([tg::TelegramClient]; kwargs...)

Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Pass False for all boolean parameters to demote a user. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `user_id`: (Integer) Unique identifier of the target user

# Optional arguments
- `is_anonymous`: (Boolean) Pass True, if the administrator's presence in the chat is hidden
- `can_manage_chat`: (Boolean) Pass True, if the administrator can access the chat event log, chat statistics, message statistics in channels, see channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other administrator privilege
- `can_post_messages`: (Boolean) Pass True, if the administrator can create channel posts, channels only
- `can_edit_messages`: (Boolean) Pass True, if the administrator can edit messages of other users and can pin messages, channels only
- `can_delete_messages`: (Boolean) Pass True, if the administrator can delete messages of other users
- `can_manage_voice_chats`: (Boolean) Pass True, if the administrator can manage voice chats
- `can_restrict_members`: (Boolean) Pass True, if the administrator can restrict, ban or unban chat members
- `can_promote_members`: (Boolean) Pass True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by him)
- `can_change_info`: (Boolean) Pass True, if the administrator can change chat title, photo and other settings
- `can_invite_users`: (Boolean) Pass True, if the administrator can invite new users to the chat
- `can_pin_messages`: (Boolean) Pass True, if the administrator can pin messages, supergroups only

[Function documentation source](https://core.telegram.org/bots/api#promotechatmember)
"""),
(:setChatAdministratorCustomTitle, """
	setChatAdministratorCustomTitle([tg::TelegramClient]; kwargs...)

Use this method to set a custom title for an administrator in a supergroup promoted by the bot. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`)
- `user_id`: (Integer) Unique identifier of the target user
- `custom_title`: (String) New custom title for the administrator; 0-16 characters, emoji are not allowed

[Function documentation source](https://core.telegram.org/bots/api#setchatadministratorcustomtitle)
"""),
(:setChatPermissions, """
	setChatPermissions([tg::TelegramClient]; kwargs...)

Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the can_restrict_members admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`)
- `permissions`: (ChatPermissions) New default chat permissions

[Function documentation source](https://core.telegram.org/bots/api#setchatpermissions)
"""),
(:exportChatInviteLink, """
	exportChatInviteLink([tg::TelegramClient]; kwargs...)

Use this method to generate a new primary invite link for a chat; any previously generated primary link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns the new invite link as String on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

Note: Each administrator in a chat generates their own invite links. Bots can't use invite links generated by other administrators. If you want your bot to work with invite links, it will need to generate its own link using [`exportChatInviteLink`](@ref) or by calling the [`getChat`](@ref) method. If your bot needs to generate a new primary invite link replacing its previous one, use [`exportChatInviteLink`](@ref) again.

[Function documentation source](https://core.telegram.org/bots/api#exportchatinvitelink)
"""),
(:createChatInviteLink, """
	createChatInviteLink([tg::TelegramClient]; kwargs...)

Use this method to create an additional invite link for a chat. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. The link can be revoked using the method [`revokeChatInviteLink`](@ref). Returns the new invite link as [ChatInviteLink](https://core.telegram.org/bots/api#chatinvitelink) object.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

# Optional arguments
- `expire_date`: (Integer) Point in time (Unix timestamp) when the link will expire
- `member_limit`: (Integer) Maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999

[Function documentation source](https://core.telegram.org/bots/api#createchatinvitelink)
"""),
(:editChatInviteLink, """
	editChatInviteLink([tg::TelegramClient]; kwargs...)

Use this method to edit a non-primary invite link created by the bot. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns the edited invite link as a [ChatInviteLink](https://core.telegram.org/bots/api#chatinvitelink) object.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `invite_link`: (String) The invite link to edit

# Optional arguments
- `expire_date`: (Integer) Point in time (Unix timestamp) when the link will expire
- `member_limit`: (Integer) Maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999

[Function documentation source](https://core.telegram.org/bots/api#editchatinvitelink)
"""),
(:revokeChatInviteLink, """
	revokeChatInviteLink([tg::TelegramClient]; kwargs...)

Use this method to revoke an invite link created by the bot. If the primary link is revoked, a new link is automatically generated. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns the revoked invite link as [ChatInviteLink](https://core.telegram.org/bots/api#chatinvitelink) object.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier of the target chat or username of the target channel (in the format `@channelusername`)
- `invite_link`: (String) The invite link to revoke

[Function documentation source](https://core.telegram.org/bots/api#revokechatinvitelink)
"""),
(:setChatPhoto, """
	setChatPhoto([tg::TelegramClient]; kwargs...)

Use this method to set a new profile photo for the chat. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `photo`: (InputFile) New chat photo, uploaded using multipart/form-data

[Function documentation source](https://core.telegram.org/bots/api#setchatphoto)
"""),
(:deleteChatPhoto, """
	deleteChatPhoto([tg::TelegramClient]; kwargs...)

Use this method to delete a chat photo. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#deletechatphoto)
"""),
(:setChatTitle, """
	setChatTitle([tg::TelegramClient]; kwargs...)

Use this method to change the title of a chat. Titles can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `title`: (String) New chat title, 1-255 characters

[Function documentation source](https://core.telegram.org/bots/api#setchattitle)
"""),
(:setChatDescription, """
	setChatDescription([tg::TelegramClient]; kwargs...)

Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

# Optional arguments
- `description`: (String) New chat description, 0-255 characters

[Function documentation source](https://core.telegram.org/bots/api#setchatdescription)
"""),
(:pinChatMessage, """
	pinChatMessage([tg::TelegramClient]; kwargs...)

Use this method to add a message to the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' admin right in a supergroup or 'can_edit_messages' admin right in a channel. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Identifier of a message to pin

# Optional arguments
- `disable_notification`: (Boolean) Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels and private chats.

[Function documentation source](https://core.telegram.org/bots/api#pinchatmessage)
"""),
(:unpinChatMessage, """
	unpinChatMessage([tg::TelegramClient]; kwargs...)

Use this method to remove a message from the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' admin right in a supergroup or 'can_edit_messages' admin right in a channel. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

# Optional arguments
- `message_id`: (Integer) Identifier of a message to unpin. If not specified, the most recent pinned message (by sending date) will be unpinned.

[Function documentation source](https://core.telegram.org/bots/api#unpinchatmessage)
"""),
(:unpinAllChatMessages, """
	unpinAllChatMessages([tg::TelegramClient]; kwargs...)

Use this method to clear the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' admin right in a supergroup or 'can_edit_messages' admin right in a channel. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#unpinallchatmessages)
"""),
(:leaveChat, """
	leaveChat([tg::TelegramClient]; kwargs...)

Use this method for your bot to leave a group, supergroup or channel. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#leavechat)
"""),
(:getChat, """
	getChat([tg::TelegramClient]; kwargs...)

Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a [Chat](https://core.telegram.org/bots/api#chat) object on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#getchat)
"""),
(:getChatAdministrators, """
	getChatAdministrators([tg::TelegramClient]; kwargs...)

Use this method to get a list of administrators in a chat. On success, returns an Array of [ChatMember](https://core.telegram.org/bots/api#chatmember) objects that contains information about all chat administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#getchatadministrators)
"""),
(:getChatMemberCount, """
	getChatMemberCount([tg::TelegramClient]; kwargs...)

Use this method to get the number of members in a chat. Returns Int on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`)

[Function documentation source](https://core.telegram.org/bots/api#getchatmembercount)
"""),
(:getChatMember, """
	getChatMember([tg::TelegramClient]; kwargs...)

Use this method to get information about a member of a chat. Returns a [ChatMember](https://core.telegram.org/bots/api#chatmember) object on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`)
- `user_id`: (Integer) Unique identifier of the target user

[Function documentation source](https://core.telegram.org/bots/api#getchatmember)
"""),
(:setChatStickerSet, """
	setChatStickerSet([tg::TelegramClient]; kwargs...)

Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in [`getChat`](@ref) requests to check if the bot can use this method. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`)
- `sticker_set_name`: (String) Name of the sticker set to be set as the group sticker set

[Function documentation source](https://core.telegram.org/bots/api#setchatstickerset)
"""),
(:deleteChatStickerSet, """
	deleteChatStickerSet([tg::TelegramClient]; kwargs...)

Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in [`getChat`](@ref) requests to check if the bot can use this method. Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`)

[Function documentation source](https://core.telegram.org/bots/api#deletechatstickerset)
"""),
(:answerCallbackQuery, """
	answerCallbackQuery([tg::TelegramClient]; kwargs...)

Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.

Alternatively, the user can be redirected to the specified Game URL. For this option to work, you must first create a game for your bot via @Botfather and accept the terms. Otherwise, you may use links like `t.me/your_bot?start=XXXX` that open your bot with a parameter.

# Required arguments
- `callback_query_id`: (String) Unique identifier for the query to be answered

# Optional arguments
- `text`: (String) Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
- `show_alert`: (Boolean) If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
- `url`: (String) URL that will be opened by the user's client. If you have created a [Game](https://core.telegram.org/bots/api#game) and accepted the conditions via @Botfather, specify the URL that opens your game — note that this will only work if the query comes from a [callback_game](https://core.telegram.org/bots/api#inlinekeyboardbutton) button.Otherwise, you may use links like `t.me/your_bot?start=XXXX` that open your bot with a parameter.
- `cache_time`: (Integer) The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.

[Function documentation source](https://core.telegram.org/bots/api#answercallbackquery)
"""),
(:setMyCommands, """
	setMyCommands([tg::TelegramClient]; kwargs...)

Use this method to change the list of the bot's commands. See https://core.telegram.org/bots#commands for more details about bot commands. Returns True on success.

# Required arguments
- `commands`: (Array of BotCommand) A JSON-serialized list of bot commands to be set as the list of the bot's commands. At most 100 commands can be specified.

# Optional arguments
- `scope`: (BotCommandScope) A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to [BotCommandScopeDefault](https://core.telegram.org/bots/api#botcommandscopedefault).
- `language_code`: (String) A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands

[Function documentation source](https://core.telegram.org/bots/api#setmycommands)
"""),
(:deleteMyCommands, """
	deleteMyCommands([tg::TelegramClient]; kwargs...)

Use this method to delete the list of the bot's commands for the given scope and user language. After deletion, [higher level commands](https://core.telegram.org/bots/api#determining-list-of-commands) will be shown to affected users. Returns True on success.

# Optional arguments
- `scope`: (BotCommandScope) A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to [BotCommandScopeDefault](https://core.telegram.org/bots/api#botcommandscopedefault).
- `language_code`: (String) A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands

[Function documentation source](https://core.telegram.org/bots/api#deletemycommands)
"""),
(:getMyCommands, """
	getMyCommands([tg::TelegramClient]; kwargs...)

Use this method to get the current list of the bot's commands for the given scope and user language. Returns Array of [BotCommand](https://core.telegram.org/bots/api#botcommand) on success. If commands aren't set, an empty list is returned.

# Optional arguments
- `scope`: (BotCommandScope) A JSON-serialized object, describing scope of users. Defaults to [BotCommandScopeDefault](https://core.telegram.org/bots/api#botcommandscopedefault).
- `language_code`: (String) A two-letter ISO 639-1 language code or an empty string

[Function documentation source](https://core.telegram.org/bots/api#getmycommands)
"""),
(:editMessageText, """
	editMessageText([tg::TelegramClient]; kwargs...)

Use this method to edit text and [game](https://core.telegram.org/bots/api#games) messages. On success, if the edited message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Required arguments
- `text`: (String) New text of the message, 1-4096 characters after entities parsing

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message to edit
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `parse_mode`: (String) Mode for parsing entities in the message text. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `entities`: (Array of MessageEntity) List of special entities that appear in message text, which can be specified instead of parse_mode
- `disable_web_page_preview`: (Boolean) Disables link previews for links in this message
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#editmessagetext)
"""),
(:editMessageCaption, """
	editMessageCaption([tg::TelegramClient]; kwargs...)

Use this method to edit captions of messages. On success, if the edited message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message to edit
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `caption`: (String) New caption of the message, 0-1024 characters after entities parsing
- `parse_mode`: (String) Mode for parsing entities in the message caption. See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details.
- `caption_entities`: (Array of MessageEntity) List of special entities that appear in the caption, which can be specified instead of parse_mode
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#editmessagecaption)
"""),
(:editMessageMedia, """
	editMessageMedia([tg::TelegramClient]; kwargs...)

Use this method to edit animation, audio, document, photo, or video messages. If a message is part of a message album, then it can be edited only to an audio for audio albums, only to a document for document albums and to a photo or a video otherwise. When an inline message is edited, a new file can't be uploaded; use a previously uploaded file via its file_id or specify a URL. On success, if the edited message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Required arguments
- `media`: (InputMedia) A JSON-serialized object for a new media content of the message

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message to edit
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#editmessagemedia)
"""),
(:editMessageReplyMarkup, """
	editMessageReplyMarkup([tg::TelegramClient]; kwargs...)

Use this method to edit only the reply markup of messages. On success, if the edited message is not an inline message, the edited [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned.

# Optional arguments
- `chat_id`: (Integer or String) Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the message to edit
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#editmessagereplymarkup)
"""),
(:stopPoll, """
	stopPoll([tg::TelegramClient]; kwargs...)

Use this method to stop a poll which was sent by the bot. On success, the stopped [Poll](https://core.telegram.org/bots/api#poll) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Identifier of the original message with the poll

# Optional arguments
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for a new message inline keyboard.

[Function documentation source](https://core.telegram.org/bots/api#stoppoll)
"""),
(:deleteMessage, """
	deleteMessage([tg::TelegramClient]; kwargs...)

Use this method to delete a message, including service messages, with the following limitations:- A message can only be deleted if it was sent less than 48 hours ago.- A dice message in a private chat can only be deleted if it was sent more than 24 hours ago.- Bots can delete outgoing messages in private chats, groups, and supergroups.- Bots can delete incoming messages in private chats.- Bots granted can_post_messages permissions can delete outgoing messages in channels.- If the bot is an administrator of a group, it can delete any message there.- If the bot has can_delete_messages permission in a supergroup or a channel, it can delete any message there.Returns True on success.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `message_id`: (Integer) Identifier of the message to delete

[Function documentation source](https://core.telegram.org/bots/api#deletemessage)
"""),
(:sendSticker, """
	sendSticker([tg::TelegramClient]; kwargs...)

Use this method to send static .WEBP or animated .TGS stickers. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `sticker`: (InputFile or String) Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .WEBP file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

# Optional arguments
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.

[Function documentation source](https://core.telegram.org/bots/api#sendsticker)
"""),
(:getStickerSet, """
	getStickerSet([tg::TelegramClient]; kwargs...)

Use this method to get a sticker set. On success, a [StickerSet](https://core.telegram.org/bots/api#stickerset) object is returned.

# Required arguments
- `name`: (String) Name of the sticker set

[Function documentation source](https://core.telegram.org/bots/api#getstickerset)
"""),
(:uploadStickerFile, """
	uploadStickerFile([tg::TelegramClient]; kwargs...)

Use this method to upload a .PNG file with a sticker for later use in createNewStickerSet and addStickerToSet methods (can be used multiple times). Returns the uploaded [File](https://core.telegram.org/bots/api#file) on success.

# Required arguments
- `user_id`: (Integer) User identifier of sticker file owner
- `png_sticker`: (InputFile) PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)

[Function documentation source](https://core.telegram.org/bots/api#uploadstickerfile)
"""),
(:createNewStickerSet, """
	createNewStickerSet([tg::TelegramClient]; kwargs...)

Use this method to create a new sticker set owned by a user. The bot will be able to edit the sticker set thus created. You must use exactly one of the fields png_sticker or tgs_sticker. Returns True on success.

# Required arguments
- `user_id`: (Integer) User identifier of created sticker set owner
- `name`: (String) Short name of sticker set, to be used in `t.me/addstickers/` URLs (e.g., animals). Can contain only english letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in “_by_<bot username>”. <bot_username> is case insensitive. 1-64 characters.
- `title`: (String) Sticker set title, 1-64 characters
- `emojis`: (String) One or more emoji corresponding to the sticker

# Optional arguments
- `png_sticker`: (InputFile or String) PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `tgs_sticker`: (InputFile) TGS animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
- `contains_masks`: (Boolean) Pass True, if a set of mask stickers should be created
- `mask_position`: (MaskPosition) A JSON-serialized object for position where the mask should be placed on faces

[Function documentation source](https://core.telegram.org/bots/api#createnewstickerset)
"""),
(:addStickerToSet, """
	addStickerToSet([tg::TelegramClient]; kwargs...)

Use this method to add a new sticker to a set created by the bot. You must use exactly one of the fields png_sticker or tgs_sticker. Animated stickers can be added to animated sticker sets and only to them. Animated sticker sets can have up to 50 stickers. Static sticker sets can have up to 120 stickers. Returns True on success.

# Required arguments
- `user_id`: (Integer) User identifier of sticker set owner
- `name`: (String) Sticker set name
- `emojis`: (String) One or more emoji corresponding to the sticker

# Optional arguments
- `png_sticker`: (InputFile or String) PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files)
- `tgs_sticker`: (InputFile) TGS animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
- `mask_position`: (MaskPosition) A JSON-serialized object for position where the mask should be placed on faces

[Function documentation source](https://core.telegram.org/bots/api#addstickertoset)
"""),
(:setStickerPositionInSet, """
	setStickerPositionInSet([tg::TelegramClient]; kwargs...)

Use this method to move a sticker in a set created by the bot to a specific position. Returns True on success.

# Required arguments
- `sticker`: (String) File identifier of the sticker
- `position`: (Integer) New sticker position in the set, zero-based

[Function documentation source](https://core.telegram.org/bots/api#setstickerpositioninset)
"""),
(:deleteStickerFromSet, """
	deleteStickerFromSet([tg::TelegramClient]; kwargs...)

Use this method to delete a sticker from a set created by the bot. Returns True on success.

# Required arguments
- `sticker`: (String) File identifier of the sticker

[Function documentation source](https://core.telegram.org/bots/api#deletestickerfromset)
"""),
(:setStickerSetThumb, """
	setStickerSetThumb([tg::TelegramClient]; kwargs...)

Use this method to set the thumbnail of a sticker set. Animated thumbnails can be set for animated sticker sets only. Returns True on success.

# Required arguments
- `name`: (String) Sticker set name
- `user_id`: (Integer) User identifier of the sticker set owner

# Optional arguments
- `thumb`: (InputFile or String) A PNG image with the thumbnail, must be up to 128 kilobytes in size and have width and height exactly 100px, or a TGS animation with the thumbnail up to 32 kilobytes in size; see https://core.telegram.org/animated_stickers#technical-requirements for animated sticker technical requirements. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. [More info on Sending Files »](https://core.telegram.org/bots/api#sending-files). Animated sticker set thumbnail can't be uploaded via HTTP URL.

[Function documentation source](https://core.telegram.org/bots/api#setstickersetthumb)
"""),
(:answerInlineQuery, """
	answerInlineQuery([tg::TelegramClient]; kwargs...)

Use this method to send answers to an inline query. On success, True is returned.No more than 50 results per query are allowed.

# Required arguments
- `inline_query_id`: (String) Unique identifier for the answered query
- `results`: (Array of InlineQueryResult) A JSON-serialized array of results for the inline query

# Optional arguments
- `cache_time`: (Integer) The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.
- `is_personal`: (Boolean) Pass True, if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query
- `next_offset`: (String) Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don't support pagination. Offset length can't exceed 64 bytes.
- `switch_pm_text`: (String) If passed, clients will display a button with specified text that switches the user to a private chat with the bot and sends the bot a start message with the parameter switch_pm_parameter
- `switch_pm_parameter`: (String) Deep-linking parameter for the /start message sent to the bot when user presses the switch button. 1-64 characters, only `A-Z`, `a-z`, `0-9`, `_` and `-` are allowed.Example: An inline bot that sends YouTube videos can ask the user to connect the bot to their YouTube account to adapt search results accordingly. To do this, it displays a 'Connect your YouTube account' button above the results, or even before showing any. The user presses the button, switches to a private chat with the bot and, in doing so, passes a start parameter that instructs the bot to return an oauth link. Once done, the bot can offer a [switch_inline](https://core.telegram.org/bots/api#inlinekeyboardmarkup) button so that the user can easily return to the chat where they wanted to use the bot's inline capabilities.

[Function documentation source](https://core.telegram.org/bots/api#answerinlinequery)
"""),
(:sendInvoice, """
	sendInvoice([tg::TelegramClient]; kwargs...)

Use this method to send invoices. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer or String) Unique identifier for the target chat or username of the target channel (in the format `@channelusername`)
- `title`: (String) Product name, 1-32 characters
- `description`: (String) Product description, 1-255 characters
- `payload`: (String) Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.
- `provider_token`: (String) Payments provider token, obtained via Botfather
- `currency`: (String) Three-letter ISO 4217 currency code, see more on currencies
- `prices`: (Array of LabeledPrice) Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)

# Optional arguments
- `max_tip_amount`: (Integer) The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of `US$ 1.45` pass `max_tip_amount = 145`. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0
- `suggested_tip_amounts`: (Array of Integer) A JSON-serialized array of suggested amounts of tips in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.
- `start_parameter`: (String) Unique deep-linking parameter. If left empty, forwarded copies of the sent message will have a Pay button, allowing multiple users to pay directly from the forwarded message, using the same invoice. If non-empty, forwarded copies of the sent message will have a URL button with a deep link to the bot (instead of a Pay button), with the value used as the start parameter
- `provider_data`: (String) A JSON-serialized data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.
- `photo_url`: (String) URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service. People like it better when they see what they are paying for.
- `photo_size`: (Integer) Photo size
- `photo_width`: (Integer) Photo width
- `photo_height`: (Integer) Photo height
- `need_name`: (Boolean) Pass True, if you require the user's full name to complete the order
- `need_phone_number`: (Boolean) Pass True, if you require the user's phone number to complete the order
- `need_email`: (Boolean) Pass True, if you require the user's email address to complete the order
- `need_shipping_address`: (Boolean) Pass True, if you require the user's shipping address to complete the order
- `send_phone_number_to_provider`: (Boolean) Pass True, if user's phone number should be sent to provider
- `send_email_to_provider`: (Boolean) Pass True, if user's email address should be sent to provider
- `is_flexible`: (Boolean) Pass True, if the final price depends on the shipping method
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard. If empty, one 'Pay `total price`' button will be shown. If not empty, the first button must be a Pay button.

[Function documentation source](https://core.telegram.org/bots/api#sendinvoice)
"""),
(:answerShippingQuery, """
	answerShippingQuery([tg::TelegramClient]; kwargs...)

If you sent an invoice requesting a shipping address and the parameter is_flexible was specified, the Bot API will send an [Update](https://core.telegram.org/bots/api#update) with a shipping_query field to the bot. Use this method to reply to shipping queries. On success, True is returned.

# Required arguments
- `shipping_query_id`: (String) Unique identifier for the query to be answered
- `ok`: (Boolean) Specify True if delivery to the specified address is possible and False if there are any problems (for example, if delivery to the specified address is not possible)

# Optional arguments
- `shipping_options`: (Array of ShippingOption) Required if ok is True. A JSON-serialized array of available shipping options.
- `error_message`: (String) Required if ok is False. Error message in human readable form that explains why it is impossible to complete the order (e.g. "Sorry, delivery to your desired address is unavailable'). Telegram will display this message to the user.

[Function documentation source](https://core.telegram.org/bots/api#answershippingquery)
"""),
(:answerPreCheckoutQuery, """
	answerPreCheckoutQuery([tg::TelegramClient]; kwargs...)

Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an [Update](https://core.telegram.org/bots/api#update) with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.

# Required arguments
- `pre_checkout_query_id`: (String) Unique identifier for the query to be answered
- `ok`: (Boolean) Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.

# Optional arguments
- `error_message`: (String) Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. "Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!"). Telegram will display this message to the user.

[Function documentation source](https://core.telegram.org/bots/api#answerprecheckoutquery)
"""),
(:setPassportDataErrors, """
	setPassportDataErrors([tg::TelegramClient]; kwargs...)

Informs a user that some of the Telegram Passport elements they provided contains errors. The user will not be able to re-submit their Passport to you until the errors are fixed (the contents of the field for which you returned the error must change). Returns True on success.

Use this if the data submitted by the user doesn't satisfy the standards your service requires for any reason. For example, if a birthday date seems invalid, a submitted document is blurry, a scan shows evidence of tampering, etc. Supply some details in the error message to make sure the user knows how to correct the issues.

# Required arguments
- `user_id`: (Integer) User identifier
- `errors`: (Array of PassportElementError) A JSON-serialized array describing the errors

[Function documentation source](https://core.telegram.org/bots/api#setpassportdataerrors)
"""),
(:sendGame, """
	sendGame([tg::TelegramClient]; kwargs...)

Use this method to send a game. On success, the sent [Message](https://core.telegram.org/bots/api#message) is returned.

# Required arguments
- `chat_id`: (Integer) Unique identifier for the target chat
- `game_short_name`: (String) Short name of the game, serves as the unique identifier for the game. Set up your games via Botfather.

# Optional arguments
- `disable_notification`: (Boolean) Sends the message silently. Users will receive a notification with no sound.
- `reply_to_message_id`: (Integer) If the message is a reply, ID of the original message
- `allow_sending_without_reply`: (Boolean) Pass True, if the message should be sent even if the specified replied-to message is not found
- `reply_markup`: (InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard. If empty, one 'Play game_title' button will be shown. If not empty, the first button must launch the game.

[Function documentation source](https://core.telegram.org/bots/api#sendgame)
"""),
(:setGameScore, """
	setGameScore([tg::TelegramClient]; kwargs...)

Use this method to set the score of the specified user in a game message. On success, if the message is not an inline message, the [Message](https://core.telegram.org/bots/api#message) is returned, otherwise True is returned. Returns an error, if the new score is not greater than the user's current score in the chat and force is False.

# Required arguments
- `user_id`: (Integer) User identifier
- `score`: (Integer) New score, must be non-negative

# Optional arguments
- `force`: (Boolean) Pass True, if the high score is allowed to decrease. This can be useful when fixing mistakes or banning cheaters
- `disable_edit_message`: (Boolean) Pass True, if the game message should not be automatically edited to include the current scoreboard
- `chat_id`: (Integer) Required if inline_message_id is not specified. Unique identifier for the target chat
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the sent message
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message

[Function documentation source](https://core.telegram.org/bots/api#setgamescore)
"""),
(:getGameHighScores, """
	getGameHighScores([tg::TelegramClient]; kwargs...)

Use this method to get data for high score tables. Will return the score of the specified user and several of their neighbors in a game. On success, returns an Array of [GameHighScore](https://core.telegram.org/bots/api#gamehighscore) objects.

This method will currently return scores for the target user, plus two of their closest neighbors on each side. Will also return the top three users if the user and his neighbors are not among them. Please note that this behavior is subject to change.

# Required arguments
- `user_id`: (Integer) Target user id

# Optional arguments
- `chat_id`: (Integer) Required if inline_message_id is not specified. Unique identifier for the target chat
- `message_id`: (Integer) Required if inline_message_id is not specified. Identifier of the sent message
- `inline_message_id`: (String) Required if chat_id and message_id are not specified. Identifier of the inline message

[Function documentation source](https://core.telegram.org/bots/api#getgamehighscores)
"""),
]