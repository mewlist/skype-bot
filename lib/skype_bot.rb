#coding: utf-8

require 'skyper'

#
# 同じマシンで立ち上がっているSkypeクライアントから
# room_name で指定されたトピックを持つ部屋へ発言することができる
#
# bot = SkypeBot.new('開発部屋')
# bot.send('こんにちは僕はろぼっとです')
#
class SkypeBot
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

  def send( message )
    @chat.chat_message(message)
  end
end
