require 'facebook/messenger'

Bot.on :message do |message|
  case message.text
  when /hello/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: 'Hello, human! Who is your favorite bot?',
            buttons: [
              { type: 'postback', title: 'You are!', payload: 'HARMLESS' },
              { type: 'postback', title: "I don't know!", payload: 'EXTERMINATE' }
            ]
          }
        }
      }
    )
  when /girafales/i
    Bot.deliver( recipient: message.sender, message: { text: 'Let me show you something' } )
    Bot.deliver( recipient: message.sender, message: { text: 'https://www.girafales.com' } )
  else
    Bot.deliver(
      recipient: message.sender,
      message: { text: "I can't help you. I'm calling a humam to talk to you. =)" }
    )
  end
end
