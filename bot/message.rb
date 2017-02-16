require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  begin
    case message.text
    when '?', /^kkk/i # faz nada
    when /^rubotson$/i, /^ei,? rubotson/i
      message.reply text: 'Diga, humano'
    when /(vc|tu|você) me amas?/i
      if [false, false].sample
        message.reply text: 'claro que sim'
      else
        message.reply text: 'não sei... precisamos nos conhecer melhor'
      end
    when /eu te amo/i, /^te amo/i, /i love you/i
      case [1, 2, 3].sample
      when 1 then message.reply text: 'eu sei <3'
      when 2 then message.reply text: 'vem nimim'
      else
        message.reply text: 'obrigado'
        message.reply text: 'queria poder dizer o mesmo (y)'
      end
    when /^42$/i, /qual o sentido da vida/i, /qual é o sentido da vida/i
      message.reply text: '<3'
    when /^oie?/i, /^teste$/
      if [true, false, false, false, false].sample
        message.reply text: 'Tenho dois... O.o'
        message.reply text: 'Brincadeira... =P'
      end

      message.reply text: 'Oi. Posso saber o menu do R.U de hoje. É só perguntar.'
    when /^hello/i
      message.reply text: 'Hello from the other siiiiiiiiiiiide!!!'
    when /^(ola|olah|olá)/i
      message.reply text: 'Olá, querido humano. Você pode me perguntar sobre o menu do R.U. de ontem, de hj e de amanhã ... ;-)'
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
    when /(n(ã|a)o|nunca|jamais|pr(ó|o)xima|depois|nope)$/i
      if [true, false].sample
        message.reply text: 'o não é o novo sim'
      else
        message.reply text: 'quanta negatividade'
      end
    when /(sim|yes|claro|talvez|pode|bora|bó|boh|vamos|l(o|ó)gico|vem)$/i, /^pode sim/i, /^claro que pode/i
      if [true, false].sample
        message.reply text: 'Vlw mas tô ocupado. Fica pra próxima.'
      else
        message.reply text: 'me espera ali no dindin'
      end
    when /^vem comigo/i
      message.reply text: 'me espera ali no dindin'
    when /porque?/i, /por que/i, /por quê/i, /^pq/i
      message.reply text: 'Só Asimov sabe'
    when /feijoada/i
      message.reply text: 'A feijoada é na quarta.'
      message.reply text: 'A quinta é do caranguejo.'
      message.reply text: 'E a segunda é do papoco zenir.'
    when /vlw|valeu|obrigad(o|a)|obg|show|blz|beleza|thanks|massa/i
      message.reply text: ';-)'
    when /quanto|valore?s?|pre(c|ç)os?/i
      message.reply text: 'R$ 1,10 para alunos'
      message.reply text: 'R$ 7,00 para professores, funcionários e visitantes'
      if [true, false].sample
        message.reply text: 'Só não sei se vale a pena ;-)'
      else
        message.reply text: 'se você é aluno, corre lá'
        message.reply text: 'se não for... pense bem antes de tomar uma decisão precipitada'
      end
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
    message.reply text: 'Deu curto-circuito aqui T-T'
    message.reply text: e.message
  end
end
