require 'uri'
require 'open-uri'
require 'nokogiri'

class ContentReader
  def self.nokogiri_page(link)
    full_url = URI.escape(link).to_s

    # http://www.useragentstring.com/pages/useragentstring.php?name=Chrome
    user_agent = 'Rubotson/2.0 Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'

    Nokogiri::HTML(open(full_url, 'User-Agent' => user_agent).read, nil, 'UTF-8')
  end

  def self.menu(week_day: Date.today, daytime: :almoco)
    page = nokogiri_page "http://www.ufc.br/restaurante/cardapio/1-restaurante-universitario-de-fortaleza/#{week_day.to_s}"

    # linhas da tabela
    rows = page.xpath("//div[contains(@class, 'c-cardapios')]//table//tbody//tr")

    key = :desjejum
    options = {
                desjejum: [],
                almoco: [],
                jantar: []
              }

    bebidas   = rows.xpath("//table[contains(@class, 'desjejum')]//td[contains(@class, 'bebida')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    paes      = rows.xpath("//table[contains(@class, 'desjejum')]//td[contains(@class, 'paes')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    frutas    = rows.xpath("//table[contains(@class, 'desjejum')]//td[contains(@class, 'frutas')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    especial  = rows.xpath("//table[contains(@class, 'desjejum')]//td[contains(@class, 'especial')]//span[contains(@class, 'desc')]/text()").map(&:to_s)

    desjejum = []
    desjejum << { name: 'Bebidas', options: bebidas.join(', ') }
    desjejum << { name: 'Pães', options: paes.join(', ') }
    desjejum << { name: 'Frutas', options: frutas.join(', ') }
    desjejum << { name: 'Especial', options: especial.join(', ') }

    options[:desjejum] = desjejum

    principal       = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'principal')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    vegetariano     = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'vegetariano')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    salada          = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'salada')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    guarnicao       = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'guarnicao')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    acompanhamento  = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'acompanhamento')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    suco            = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'suco')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    sobremesa       = rows.xpath("//table[contains(@class, 'almoco')]//td[contains(@class, 'sobremesa')]//span[contains(@class, 'desc')]/text()").map(&:to_s)

    almoco = []
    almoco << { name: 'Principal',      options: principal.join(', ') }
    almoco << { name: 'Vegetariano',    options: vegetariano.join(', ') }
    almoco << { name: 'Salada',         options: salada.join(', ') }
    almoco << { name: 'Guarnição',      options: guarnicao.join(', ') }
    almoco << { name: 'Acompanhamento', options: acompanhamento.join(', ') }
    almoco << { name: 'Suco',           options: suco.join(', ') }
    almoco << { name: 'Sobremesa',      options: sobremesa.join(', ') }

    options[:almoco] = almoco

    # jantar

    principal       = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'principal')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    vegetariano     = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'vegetariano')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    salada          = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'salada')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    guarnicao       = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'guarnicao')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    acompanhamento  = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'acompanhamento')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    suco            = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'suco')]//span[contains(@class, 'desc')]/text()").map(&:to_s)
    sobremesa       = rows.xpath("//table[contains(@class, 'jantar')]//td[contains(@class, 'sobremesa')]//span[contains(@class, 'desc')]/text()").map(&:to_s)

    jantar = []
    jantar << { name: 'Principal',      options: principal.join(', ') }
    jantar << { name: 'Vegetariano',    options: vegetariano.join(', ') }
    jantar << { name: 'Salada',         options: salada.join(', ') }
    jantar << { name: 'Guarnição',      options: guarnicao.join(', ') }
    jantar << { name: 'Acompanhamento', options: acompanhamento.join(', ') }
    jantar << { name: 'Suco',           options: suco.join(', ') }
    jantar << { name: 'Sobremesa',      options: sobremesa.join(', ') }

    options[:jantar] = jantar

    # rows.map do |row|
    #   # cada periodo tem uma tabela: Desjejum, Almoco, Jantar
    #   # trata se o texto for "almoco"
    #   if (h3 = row.xpath("td/h3/text()").to_s.downcase.gsub('ç', 'c')) != ''
    #     key = h3.to_sym
    #     next
    #   end
    #
    #   options_key = []
    #
    #   row.xpath("td[position() > 1]/span").each_with_index do |opk, index|
    #     with_restriction = opk.attributes['class'].value.include?('lactose') || opk.attributes['class'].value.include?('gluten')
    #
    #     options_key[index - 1] = "#{options_key[index - 1]} #{opk.xpath('text()').to_s.strip}" if with_restriction
    #     options_key[index] = opk.xpath('text()').to_s unless with_restriction
    #   end
    #
    #   options[key] << {
    #                     name: row.xpath("td[1]/span/text()").to_s,
    #                     options: options_key.compact
    #                   }
    # end

    options[daytime]
  end

  def self.show_menu(responder:, week_day:, daytime:)
    # se for final de semana
    if [0, 6].include? Time.now.wday
      responder.reply text: 'meu fi... em pleno final de semana vc querendo saber se pode almoçar no RU?'
      responder.reply text: ['vá fritar um ovo',
                              'vá fazer um miojo pra não ficar com fome',
                              'vá comer um recheado com cajuína pra segurar a fome',
                              'vá fazer um macarrão com salsicha pra passar a fome'].sample
    else
      # TODO: remover
      responder.reply(text: 'agora que o carnaval acabou e tá todo mundo liso... todo mundo voltando pro RU') if Time.now < Time.parse("2017-03-05")
      show_menu2 responder: responder, week_day: week_day, daytime: daytime
    end
  end

  def self.show_menu2(responder:, week_day:, daytime:)
    begin
      if [true, false].sample
        responder.reply text: 'Vou ali olhar no site'
        responder.reply text: ['é vuado', 'calma aí'].sample
      else
        responder.reply text: 'Olhando aqui o site, peraí. Fala mais nada não.'
      end

      page_content = ContentReader.menu(week_day: week_day, daytime: daytime)

      if page_content.any? && page_content.first[:options].any?
        page_content.each do |r|
          # responder.reply text: "Em #{r[:name]} tem: #{r[:options].join(', ')}"
          options = [r[:options][0...-1].join(', '), r[:options].last].compact.reject{ |o| o.empty? }.join(' e ')
          responder.reply text: "Em #{r[:name]} tem #{options}"
        end

        response_text = case [1, 2, 3, 4, 5, 6, 7, 8].sample
                        when 1 then 'Posso ir contigo? =D'
                        when 2 then 'Dizem que tá bom'
                        when 3 then 'Acho que dá pra encarar'
                        when 4 then 'Só o filé'
                        when 5 then 'Vai na fé'
                        else;
                        end
      else
        response_text = "Tem nada no site. O #{payload.first} vai ter que ser feito em outro lugar. =("
      end

      responder.reply(text: response_text) if response_text
    rescue => e
      responder.reply text: 'Não consegui ver o que tem pra comer =/'
      responder.reply text: 'Acho que vamos ficar com fome T-T'
      # responder.reply text: "O erro foi esse:"
      # responder.reply text: e.message
    end
  end

  def self.menu_options(week_day: :today, text: 'Fala que eu te escuto.')
    {
      type: 'template',
      payload: {
        template_type: 'button',
        text: text,
        buttons: [
          { type: 'postback', title: 'Café da Manhã', payload: week_day == :today ? 'DESJEJUM' : 'DESJEJUM_TOMORROW' },
          { type: 'postback', title: "Almoço", payload: week_day == :today ? 'ALMOCO' : 'ALMOCO_TOMORROW' },
          { type: 'postback', title: "Janta", payload: week_day == :today ? 'JANTAR' : 'JANTAR_TOMORROW' }
        ]
      }
    }
  end

  def self.say_something_nice(responder:)
    responder.reply text: something_nice
  end

  private

  def self.something_nice
    [
      "abri um biscoito da sorte e o papel dizia que ele tava vencido... =(",
      "é melhor acordar arrependido que dormir com a vontade",
      "cante como se ninguém estivesse ouvindo",
      "se molhou na chuva? olha o lado positivo... hoje você já tomou banho \\o/"
    ].sample
  end
end
