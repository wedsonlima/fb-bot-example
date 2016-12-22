require 'facebook/messenger'

Bot.on :postback do |postback|
  payload = postback.payload.to_s.downcase.split('_')
  week_day = payload.last == 'tomorrow' ? Date.today + 1 : Date.today
  daytime = payload.first.to_sym

  ContentReader.show_menu responder: postback, week_day: week_day, daytime: daytime
end

# Bot.on :optin do |optin|
#   # optin.sender    # => { 'id' => '1008372609250235' }
#   # optin.recipient # => { 'id' => '2015573629214912' }
#   # optin.sent_at   # => 2016-04-22 21:30:36 +0200
#   # optin.ref       # => 'CONTACT_SKYNET'
#   #
#   # optin.reply(text: 'Ah, human!')
# end

# Bot.on :delivery do |delivery|
#   # delivery.ids       # => 'mid.1457764197618:41d102a3e1ae206a38'
#   # delivery.sender    # => { 'id' => '1008372609250235' }
#   # delivery.recipient # => { 'id' => '2015573629214912' }
#   # delivery.at        # => 2016-04-22 21:30:36 +0200
#   # delivery.seq       # => 37
#
#   puts "Human was online at #{delivery.at}"
# end

# Bot.on :referral do |referral|
#   # referral.sender    # => { 'id' => '1008372609250235' }
#   # referral.recipient # => { 'id' => '2015573629214912' }
#   # referral.sent_at   # => 2016-04-22 21:30:36 +0200
#   # referral.ref       # => 'MYPARAM'
# end
