module Skype
  module Bot
    module Bots
      autoload :GerritBot, 'skype/bot/bots/gerrit_bot'
      autoload :FeedBot,   'skype/bot/bots/feed_bot'
      autoload :FeedsBot,  'skype/bot/bots/feeds_bot'
      autoload :AzmsBot,   'skype/bot/bots/azms_bot'
      autoload :StewardBot,'skype/bot/bots/steward_bot'
      autoload :HelloBot,  'skype/bot/bots/hello_bot'
      autoload :ScheduleBot,'skype/bot/bots/schedule_bot'
    end
  end
end