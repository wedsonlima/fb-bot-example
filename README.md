Wed Bot
================

# Server

```ruby
$>
bundle exec irb
bundle exec shotgun config.ru
```

# Texto de saudação do bot

https://developers.facebook.com/docs/messenger-platform/thread-settings/greeting-text

## ADD

curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type":"greeting",
  "greeting":{
    "text": "Você é humano? Estuda na UFC? Come no RU? Dá comida pros gatos que ficam do lado do seu prato naquela linda mesa? Leva comida no copinho pros cachorros? Volta naquele bus super refrescante? Me manda um oi que você precisa de alegria na sua vida."
  }
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"

## REMOVE

curl -X DELETE -H "Content-Type: application/json" -d '{
  "setting_type":"greeting"
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"

# Persistent menu

## ADD

curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type" : "call_to_actions",
  "thread_state" : "existing_thread",
  "call_to_actions":[
    {
      "type":"postback",
      "title":"Café da manhã",
      "payload":"DESJEJUM"
    },
    {
      "type":"postback",
      "title":"Almoço",
      "payload":"ALMOCO"
    },
    {
      "type":"postback",
      "title":"Jantar",
      "payload":"JANTAR"
    },
    {
      "type":"postback",
      "title":"Melhora meu dia",
      "payload":"SAY_SOMETHING_NICE"
    }
  ]
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=EAAR84tYgUw8BAMoUYZCkaiuyuImLVODLRcSePeFixQrimkR5iBdJY7u9TPcJyDPfwcYD1xmG8YAUp4UKaUqjdsKgPzYZBmuGHYFENIe6CxmX7KU5xh17IeNI2wAzU0bWN709hb2tfzDgXUH5laT9zjvZAguETe4VBjJTBoMpwZDZD"

## REMOVE

curl -X DELETE -H "Content-Type: application/json" -d '{
  "setting_type":"call_to_actions",
  "thread_state":"existing_thread"
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"
