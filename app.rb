require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    slim :'app/index'
  end

  get '/agent' do
    slim :'app/agent'
  end
end
