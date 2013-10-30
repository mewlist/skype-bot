require 'uri'
require 'net/http'
require 'open-uri'
require 'yaml'
require 'feed-normalizer'
require 'active_support/core_ext/object'

class Skype::Bot::Bots::FeedBot
  @mutex ||= Mutex.new
  def self.mutex; @mutex end
  def listen(config)
    @config = config

    puts "feed listening    : #{@config.url}"
    puts "feed refresh rate : #{@config.refresh_rate} sec."

    Thread.new do
      loop do
        feed = FeedNormalizer::FeedNormalizer.parse(feed_content)
        raise "The URL is invalid #{@config.url}" if feed.nil?

        self.class.mutex.synchronize do
          ids = load_ids
          feed.entries.each do |item|
            unless ids.include? item.id
              chat "#{item.title} #{item.url}"
              ids.push item.id
            end
          end
          save_ids(ids)
        end

        sleep(@config.refresh_rate)
      end
    end
  end

  def feed_content
    read_url(@config.url)
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

  def read_url(url)
    uri = URI.parse(url)
    if uri.userinfo.present?
      request = Net::HTTP::Get.new(uri.path)
      account, password = *uri.userinfo.split(':')
      request.basic_auth(account, password)
      Net::HTTP.start(uri.host, uri.port).request(request).body
    else
      open(url).read
    end
  end
end
