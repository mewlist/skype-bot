class Skype::Bot::Bots::HelloBot
  def self.hello
    hello_bot = self.new
    hello_bot.bot.chat hello_bot.hello_message
  end

  def self.goodbye(death_throes_message)
    hello_bot = self.new
    hello_bot.bot.chat death_throes_message
    hello_bot.bot.chat hello_bot.goodbye_message
  end

  def bot
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
  end

  def hello_message
    aa = <<EOS
．　　∧∧      むくり
　　（*･ω･）
　 ＿|　⊃／(＿＿_
／　└-(＿＿＿_／
￣￣￣￣￣￣￣
EOS
    aa
  end

  def goodbye_message
    aa = <<EOS
. 　 ⊂⌒／ヽ-、＿_
　／⊂_/＿＿＿＿ ／
　￣￣￣￣￣￣￣
EOS
    aa
  end
end
