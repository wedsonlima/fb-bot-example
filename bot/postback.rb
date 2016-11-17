Bot.on :postback do |postback|
  text = case postback.payload
          when 'HENRIQUE_EH_CARECA' then 'Sabia que você iria concordar.. =D'
          when 'HENRIQUE_TA_FICANDO_CARECA' then 'Quase nada pra virar o Fernando.'
          when 'HENRIQUE_CARECA_SEM_COMENTARIOS' then 'Melhor preservar a amizade mesmo.'
          else
            'Não sei o que dizer'
          end

  Bot.deliver(
    recipient: postback.sender,
    message: { text: text }
  )
end
