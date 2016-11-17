Bot.on :message do |message|
  case message.text
  when /hello/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: 'Hello, human!',
        quick_replies: [
          {
            content_type: 'text',
            title: 'Hello, bot!',
            payload: 'HELLO_BOT'
          }
        ]
      }
    )
  when /henrique/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: 'Você acha que o Henrique é careca?',
            buttons: [
              { type: 'postback', title: 'Sim', payload: 'HENRIQUE_EH_CARECA' },
              { type: 'postback', title: 'Não, mas tá ficando', payload: 'HENRIQUE_TA_FICANDO_CARECA' },
              { type: 'postback', title: 'Prefiro não comentar', payload: 'HENRIQUE_CARECA_SEM_COMENTARIOS' }
            ]
          }
        }
      }
    )
  else
    Bot.deliver(
      recipient: message.sender,
      message: {
        attachment: {
          type: 'image',
          payload: {
            url: 'https://i.imgur.com/iMKrDQc.gif'
          }
        }
      }
    )
  end
end
