require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  begin
    case message.text
    when '?' # faz nada
    when /vlw|valeu|obrigado|obg|show|thanks/i
      message.reply text: ';-)'
    when /quanto|valore?s?|pre(c|ç)os?/i
      message.reply text: 'R$ 1,10 para alunos.'
      message.reply text: 'R$ 7,00 para professores, funcionários e visitantes.'
      message.reply text: 'Só não sei se vale a pena. ;-)'
    when /n(ã|a)o|nunca|jamais|pr(ó|o)xima|depois|nope/i
      message.reply text: 'Nem queria mesmo.'
    when /sim|yes|claro|talvez/i
      message.reply text: 'Vlw mas tô ocupado. Fica pra próxima.'
    when /fuder/i
      message.reply text: 'Depois de você.'
    when /a(i|í) dentr?o/i
      message.reply text: 'Do teu.'
    when /alm(o|u)(ç|c)(o|ar) (hoje|hj)/i, /alm(o|u)(ç|c)(o|ar) de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :almoco
    when /alm(o|u)(ç|c)(o|ar) amanh(ã|a)/i, /alm(o|u)(ç|c)(o|ar) de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :almoco
    when /jantar? (hoje|hj)/i, /jantar? de (hoje|hj)/i
      ContentReader.show_menu responder: message, week_day: Date.today, daytime: :jantar
    when /jantar? amanh(ã|a)/i, /jantar? de amanh(ã|a)/i
      ContentReader.show_menu responder: message, week_day: Date.today + 1, daytime: :jantar
    when /ontem?/i
      message.reply text: 'Lembro não, oh. Talez eu saiba pra hoje ou pra amanhã.'
    when /hoje/i
      message.reply attachment: ContentReader.menu_options(text: 'Hoje pra qual horário?')
    when /amanhã?/i
      message.reply attachment: ContentReader.menu_options(text: 'Amanhã pra qual horário?', week_day: :tomorrow)
    else
      message.reply text: 'Calma, Humano. Sou apenas um bot de 1a geração e não entendo tudo que você diz.'
      message.reply attachment: ContentReader.menu_options(text: 'Quer ir no RU hoje pra fazer o que? (É só clicar)')
    end
  rescue => e
    message.reply text: 'Deu curto-circuito aqui.'
    message.reply text: e.message
  end
end
