require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.app_secret = ENV['APP_SECRET']
  config.verify_token = ENV['VERIFY_TOKEN']
end
