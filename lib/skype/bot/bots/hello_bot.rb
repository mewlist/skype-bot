class Skype::Bot::Bots::HelloBot
  def self.hello
    hello_bot = self.new
    hello_bot.bot.chat hello_bot.message
  end

  def bot
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
  end

  def message
    aa = <<EOS
．　　∧∧      むくり
　　（*･ω･）
　 ＿|　⊃／(＿＿_
／　└-(＿＿＿_／
￣￣￣￣￣￣￣
EOS
    aa
  end
end
