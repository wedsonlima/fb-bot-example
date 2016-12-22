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

  def self.menu(week_day: Date.today, horario: :almoco)
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

    options[horario]
  end
end
