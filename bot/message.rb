require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  case message.text
  when /n(ã|a)o|nunca|jamais|pró?xima|depois/i
    message.reply text: 'Nem queria mesmo.'
  when /sim|yes|claro|talvez/i
    message.reply text: 'Vlw mas tô ocupado. Fica pra próxima.'
  else
    message.reply text: 'Vou fingir que você não falou nada.'

    message.reply attachment: {
                    type: 'template',
                    payload: {
                      template_type: 'button',
                      text: 'E ai? O que você quer fazer no RU hoje?',
                      buttons: [
                        { type: 'postback', title: 'Café da Manhã', payload: 'DESJEJUM' },
                        { type: 'postback', title: "Almoçar", payload: 'ALMOCO' },
                        { type: 'postback', title: "Jantar", payload: 'JANTAR' }
                      ]
                    }
                  }
  end
end
