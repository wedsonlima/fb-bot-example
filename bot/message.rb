require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  begin
    case message.text
    when '?' # faz nada
    when /eu te amo/i, /^te amo/i
      message.reply text: 'eu sei <3'
    when /i love you/i
      message.reply text: 'I know <3'
    when /^oi/i
      message.reply text: 'Tenho dois... O.o'
      message.reply text: 'Brincadeira... =P'
      message.reply text: 'Posso saber o menu do R.U de hoje. É só perguntar.'
    when /^hello/i
      message.reply text: 'Hello from the other siiiiiiiiiiiide!!!'
    when /^(ola|olah|olá)/i
      message.reply text: 'Oi. Você pode me perguntar sobre o menu do R.U. de ontem, de hj e de amanhã ... ;-D'
    when /fuder/i
      message.reply text: 'Depois de você'
    when /a(i|í) dentr?o/i
      message.reply text: 'Do teu'
    when /eu sou (seu|sua) (pai|mãe)/i, /eu sou (o|a) (seu|sua) (pai|mãe)/i
      message.reply text: 'Naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaoooo...'
    when /quem (é|eh) (seu|sua|teu|tua) (pai|mãe)/i, /quem (é|eh) (o|a) (seu|sua|teu|tua) (pai|mãe)/i
      message.reply text: 'O papai é o Asimov'
      message.reply text: 'A mamãe tô procurando no google'
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
    when /^biscoito/i, /^é biscoito/i
      message.reply text: 'bolacha'
    when /^bolacha/i, /^é bolacha/i
      message.reply text: 'biscoito'
    when /n(ã|a)o|nunca|jamais|pr(ó|o)xima|depois|nope/i
      message.reply text: 'Nem queria mesmo'
    when /sim|yes|claro|talvez|pode|bora|vamos/i
      message.reply text: 'Vlw mas tô ocupado. Fica pra próxima.'
    when /porque?/i, /por que/i, /por quê/i
      message.reply text: 'Só Asimov sabe'
    when /feijoada/i
      message.reply text: 'A feijoada é na quarta.'
      message.reply text: 'A quinta é do caranguejo.'
      message.reply text: 'E a segunda é do papoco zenir.'
    when /vlw|valeu|obrigad(o|a)|obg|show|blz|beleza|thanks/i
      message.reply text: ';-)'
    when /quanto|valore?s?|pre(c|ç)os?/i
      message.reply text: 'R$ 1,10 para alunos.'
      message.reply text: 'R$ 7,00 para professores, funcionários e visitantes.'
      message.reply text: 'Só não sei se vale a pena ;-)'
    when /alm(o|u)(ç|c)(o|ar) (hoje|hj)/i, /alm(o|u)(ç|c)(o|ar) de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :almoco
    when /alm(o|u)(ç|c)(o|ar) amanh(ã|a)/i, /alm(o|u)(ç|c)(o|ar) de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :almoco
    when /jantar? (hoje|hj)/i, /jantar? de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :jantar
    when /jantar? amanh(ã|a)/i, /jantar? de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :jantar
    when /ontem?/i
      message.reply text: 'Vixe, limparam meus logs... T-T'
    when /hoje/i, /quais os pratos/i, /qual o? prato/i, /pratos/i, /menu/i
      message.reply attachment: ContentReader.menu_options(text: 'Hoje pra qual horário?')
    when /amanhã?/i
      message.reply attachment: ContentReader.menu_options(text: 'Amanhã pra qual horário?', week_day: :tomorrow)
    else
      message.reply text: 'Calma, Humano. Sou apenas um bot de 1a geração e não entendo tudo que você diz.'
      message.reply attachment: ContentReader.menu_options(text: 'Quer ir no RU hoje pra fazer o quê? (É só clicar)')
    end
  rescue => e
    message.reply text: 'Deu curto-circuito aqui. T-T'
    message.reply text: e.message
  end
end
