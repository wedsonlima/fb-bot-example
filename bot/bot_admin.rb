require 'sinatra/base'

class BotAdmin < Sinatra::Application
  get '/' do
    content_type :json
    ContentReader.menu.to_json
  end

  get '/ontem' do
    content_type :json
    ContentReader.menu(week_day: Date.today - 1).to_json
  end

  get '/amanha' do
    content_type :json
    ContentReader.menu(week_day: Date.today + 1).to_json
  end
end
