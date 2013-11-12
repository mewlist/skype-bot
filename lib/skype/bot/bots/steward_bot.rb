require 'feed-normalizer'
require 'active_support/core_ext/object'

class Skype::Bot::Bots::StewardBot
  def listen(config)
    @config = config

    puts "stward starts listening"
    puts "redmine url: #{@config.redmine_tickets_feed_url}"

    Thread.new do
      loop do
        bot.recent.each do |chat|
          body = encode_body chat

          message = answer body
          chat message if message.present?
        end

        sleep 10
      end
    end
  end

  def answer(message)
    case message

    when /新規チケット全部を教えて/
      redmine_tickets.entries.map {|entry|
        if entry.title =~ /(新規)/
          "#{entry.title} #{entry.url}"
        end
      }.compact.join("\n")

    when /最近のチケットを教えて/
      redmine_tickets.entries
        .select {|entry| entry.last_updated > 5.days.ago }
        .map {|entry| "#{entry.title} #{entry.url}" }
        .join("\n")

    when /broken/
      "(devil) (devil) (devil) (devil) (devil)"
    end
  end

  def redmine_tickets
    feed_body = open(@config.redmine_tickets_feed_url).read
    feed = FeedNormalizer::FeedNormalizer.parse(feed_body)
  end

  def encode_body(chat)
    chat.body.encode("UTF-8", "UTF-8")
  end

  def chat(*msgs)
    puts msgs.join("\n")
    bot.chat msgs.join("\n")
  end

  def bot
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
  end
end
