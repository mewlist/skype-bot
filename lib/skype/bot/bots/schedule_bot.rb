class Skype::Bot::Bots::ScheduleBot
  def listen(config)
    @schedules = config.schedules
    @parsers = @schedules.map {|schedule| Skype::Bot::ScheduleParser.new(schedule[:rule], schedule[:message]) }

    Thread.new do
      loop do
        @parsers.each do |parser|
          if parser.pass?
            chat(parser.message)
          end
        end
        sleep 10
      end
    end
  end

  def chat(*msgs)
    puts msgs.join("\n")
    bot.chat msgs.join("\n")
  end

  def bot
    @bot ||= Skype::Bot::SkypeBot.new(Boot.config.skype.room)
  end
end
