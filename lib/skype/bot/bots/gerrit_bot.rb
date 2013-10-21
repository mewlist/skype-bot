class Skype::Bot::Bots::GerritBot < Skype::Bot::Gerrit::Streamer
  def send(*msgs)
    @bot ||= SkypeBot.new(Boot.config.skype.room)
    @bot.chat msgs.join("\n")
  end

  def patched(event)
    send "#{event.uploader}さんがパッチを投げたわよ ================================",
         "『#{event.subject}』( #{event.url} ) ",
         "みなさん、レビューお願いします！"
  end

  def reviewed(event)
    send "#{event.author}さんがレビューしたみたいよ ================================",
         " 『#{event.subject}』by #{event.owner} ( #{event.url} )",
         "  <verified : #{event.verified} reviewed : #{event.reviewed}>",
         "　#{event.comment.empty? ? "コメントは空っぽだったよ ;(" : event.comment}　"
  end

  def merged(event)
    send "> #{event.owner}さん おめでとうございます！ ================================",
         " 『#{event.subject}』( #{event.url} )",
         "#{event.submitter}さんがあなたのコミットをマージしたよ！！ (clap) (clap) (clap) (clap) "
  end
end
