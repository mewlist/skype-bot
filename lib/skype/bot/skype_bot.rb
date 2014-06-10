#coding: utf-8

#
# 同じマシンで立ち上がっているSkypeクライアントから
# room_name で指定されたトピックを持つ部屋へ発言することができる
#
# bot = SkypeBot.new('開発部屋')
# bot.chat('こんにちは僕はろぼっとです')
#
class Skype::Bot::SkypeBot
  attr_reader :chat
  def initialize(room_name)
    Skyper::Chat.recent_chats.each do |c|
        topic = c.get_property(:TOPIC).encode("UTF-8", "UTF-8")
        if topic == room_name
          @chat = c
        end
    end
    raise '部屋が見つかりませんでした' unless @chat
  end

  def chat( message )
    @chat.chat_message(message)
  end

  def recent
    now = Time.now
    @last_recent_fetched_time ||= now
    filtered = @chat.recent_chat_messages.select {|message|
      message.timestamp > @last_recent_fetched_time
    }
    unless filtered.empty?
      @last_recent_fetched_time = now
    end
    filtered
  end
end
