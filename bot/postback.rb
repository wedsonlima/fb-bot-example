require 'facebook/messenger'

Bot.on :postback do |postback|
  text = case postback.payload
          when 'HARMLESS' then "You're cool! =D"
          when 'EXTERMINATE' then "Human marked for extermination."
          else
            "I don't know what to say."
          end

  Bot.deliver(
    recipient: postback.sender,
    message: { text: text }
  )
end
