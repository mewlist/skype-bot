class Skype::Bot::Bots::FeedsBot
  def listen(config)
    config.map {|feed|
      Skype::Bot::Bots::FeedBot.new.listen(feed)
    }
  end
end
