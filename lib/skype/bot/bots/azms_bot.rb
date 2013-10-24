class Skype::Bot::Bots::AzmsBot
  def listen
    Thread.new do
      loop do
        bot.recent.each do |chat|
          p chat.body
          if /こんにちは/ =~ chat.body.encode("UTF-8", "UTF-8")
            chat "あざます!!!!!!!"
          end
        end
      end
    end
  end

  def chat(*msgs)
    puts msgs.join("\n")
    bot.chat msgs.join("\n")
  end

  def bot
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
  end
end
