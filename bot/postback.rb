require 'facebook/messenger'

Bot.on :postback do |postback|
  begin
    postback.reply text: 'Olhando aqui o site. Perai!'

    ContentReader.menu(horario: postback.payload.to_s.downcase.to_sym).each do |r|
      postback.reply text: "Em #{r[:name]} tem: #{r[:options].join(', ')}"
    end

    postback.reply text: 'Posso ir contigo? =D'
  rescue => e
    postback.reply text: "Não consegui ver o que tem pra comer. =/"
    postback.reply text: "O erro foi esse:"
    postback.reply text: e.message
  end
end
