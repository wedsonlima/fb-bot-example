require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  begin
    case message.text
    when '?' # faz nada
    when /(oi)/i
      message.reply text: 'Tenho dois... O.o'
      message.reply text: 'Brincadeira... =P'
      message.reply text: 'Posso saber os pratos do R.U de hoje. É só perguntar.'
    when /(hello)/i
      message.reply text: 'Hello from the other siiiiiiiiiiiidee!!!'
    when /(ola|olah|olá)/i
      message.reply text: 'Oi. Você pode me perguntar os pratos do R.U. e algumas outras coisas... ;-D'
    when /fuder/i
      message.reply text: 'Depois de você.'
    when /a(i|í) dentr?o/i
      message.reply text: 'Do teu.'
    when /eu sou (seu|sua) (pai|mãe)/i
      message.reply text: 'Naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaoooo...'
    when /quem (é|eh) (seu|sua|teu|tua) (pai|mãe)/i, /quem (é|eh) (o|a) (seu|sua|teu|tua) (pai|mãe)/i
      message.reply text: 'É você =D'
    when /biscoito ou bolacha/i, /bolacha ou biscoito/i
      message.reply attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Vamos ver o que os especialistas dizem:',
          buttons: [
            { type: 'web_url', title: 'É biscoito', url: 'http://mundoestranho.abril.com.br/alimentacao/o-certo-e-biscoito-ou-bolacha/' },
            { type: 'web_url', title: 'É bolacha', url: 'https://www.buzzfeed.com/clarissapassos/o-certo-eh-bolacha' }
          ]
        }
      }
    when /n(ã|a)o|nunca|jamais|pr(ó|o)xima|depois|nope/i
      message.reply text: 'Nem queria mesmo.'
    when /sim|yes|claro|talvez/i
      message.reply text: 'Vlw mas tô ocupado. Fica pra próxima.'
    when /feijoada/i
      message.reply text: 'A feijoada é na quarta.'
      message.reply text: 'A quinta é do caranguejo.'
      message.reply text: 'E a segunda do papoco zenir.'
    when /vlw|valeu|obrigado|obg|show|blz|beleza|thanks/i
      message.reply text: ';-)'
    when /quanto|valore?s?|pre(c|ç)os?/i
      message.reply text: 'R$ 1,10 para alunos.'
      message.reply text: 'R$ 7,00 para professores, funcionários e visitantes.'
      message.reply text: 'Só não sei se vale a pena. ;-)'
    when /alm(o|u)(ç|c)(o|ar) (hoje|hj)/i, /alm(o|u)(ç|c)(o|ar) de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :almoco
    when /alm(o|u)(ç|c)(o|ar) amanh(ã|a)/i, /alm(o|u)(ç|c)(o|ar) de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :almoco
    when /jantar? (hoje|hj)/i, /jantar? de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :jantar
    when /jantar? amanh(ã|a)/i, /jantar? de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :jantar
    when /ontem?/i
      message.reply text: 'Lembro não, oh.'
    when /hoje/i
      message.reply attachment: ContentReader.menu_options(text: 'Hoje pra qual horário?')
    when /amanhã?/i
      message.reply attachment: ContentReader.menu_options(text: 'Amanhã pra qual horário?', week_day: :tomorrow)
    else
      message.reply text: 'Calma, Humano. Sou apenas um bot de 1a geração e não entendo tudo que você diz.'
      message.reply attachment: ContentReader.menu_options(text: 'Quer ir no RU hoje pra fazer o que? (É só clicar)')
    end
  rescue => e
    message.reply text: 'Deu curto-circuito aqui. T-T'
    message.reply text: e.message
  end
end
