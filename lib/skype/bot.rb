require 'skyper'
require 'pry'

module Skype
  module Bot
    autoload :Bots,     'skype/bot/bots'
    autoload :Gerrit,   'skype/bot/gerrit'
    autoload :SkypeBot, 'skype/bot/skype_bot'
  end
end