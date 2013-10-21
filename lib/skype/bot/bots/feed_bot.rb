require 'open-uri'
require 'yaml'
require 'feed-normalizer'

class Skype::Bot::Bots::FeedBot
  def listen(config)
    @config = config

    puts "feed listening    : #{@config.url}"
    puts "feed refresh rate : #{@config.refresh_rate} sec."

    Thread.new do
      loop do
        feed = FeedNormalizer::FeedNormalizer.parse(feed_content)
        Thread.main.raise "cannot read the feed #{@config.url}" unless feed

        ids = load_ids
        feed.entries.each do |item|
          unless ids.include? item.id
            chat "#{item.title} #{item.url}"
            ids.push item.id
          end
        end
        save_ids(ids)

        sleep(@config.refresh_rate)
      end
    end
  end

  def feed_content
    open(@config.url).read
  end

  def ids_filepath
    ".skype_bot_feed_ids"
  end

  def save_ids(ids)
    File.write(ids_filepath, ids.to_yaml)
  end

  def load_ids
    yaml = File.read(ids_filepath)
    YAML::load(yaml)
  rescue
    []
  end

  def chat(*msgs)
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
    puts msgs.join("\n")
    @bot.chat msgs.join("\n")
  end
end
