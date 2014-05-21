class Skype::Bot::Bots::HelloBot
  def self.hello
    hello_bot = self.new
    hello_bot.bot.chat hello_bot.hello_message
  end

  def self.notify_error(e)
    hello_bot = self.new

    tracelog = e.backtrace.join("\n")
    tracelog = "#{hello_bot.error_message}\n#{e.message}\n#{e.backtrace.join("\n")}"
    STDERR.puts tracelog

    hello_bot.bot.chat tracelog
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

  def error_message
    aa = <<EOS
.　 　　(⌒⌒)
　　　　 ii!i!i 　　ﾄﾞｯｶｰﾝ!
　 　　ﾉ~~~＼
,,,,,,,／｀･ω･´ ＼,,,,,,,,,,
EOS
  end
end
