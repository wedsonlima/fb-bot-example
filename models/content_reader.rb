require 'uri'
require 'open-uri'
require 'nokogiri'

class ContentReader
  def self.nokogiri_page(link)
    full_url = URI.escape(link).to_s

    # http://www.useragentstring.com/pages/useragentstring.php?name=Chrome
    user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'

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

    rows.map do |row|
      if (h3 = row.xpath("td/h3/text()").to_s.downcase.gsub('ç', 'c')) != ''
        key = h3.to_sym
        next
      end

      options[key] << {
                  name: row.xpath("td[1]/span/text()").to_s,
                  options: row.xpath("td[position() > 1]/span[not(contains(@class, 'lactose'))][not(contains(@class, 'gluten'))]/text()").map(&:to_s)
                }
    end

    options[daytime]
  end

  def self.show_menu(responder:, week_day:, daytime:)
    begin
      responder.reply text: 'Olhando aqui o site. Peraí!'

      page_content = ContentReader.menu(week_day: week_day, daytime: daytime)

      if page_content.any? && page_content.first[:options].any?
        page_content.each do |r|
          responder.reply text: "Em #{r[:name]} tem: #{r[:options].join(', ')}"
        end

        response_text = case [1, 2, 3].sample
                        when 1 then 'Posso ir contigo? =D'
                        when 2 then 'Dizem que tá bom'
                        when 3 then 'Acho que dá pra encarar'
                        else;
                        end
      else
        response_text = "Tem nada no site. O #{payload.first} vai ter que ser feito em outro lugar. =("
      end

      responder.reply text: response_text
    rescue => e
      responder.reply text: 'Não consegui ver o que tem pra comer. =/'
      responder.reply text: 'Acho que vamos ficar com fome. T-T'
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
end
