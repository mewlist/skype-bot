require 'cron_parser'

class Skype::Bot::ScheduleParser
  attr_accessor :message

  def initialize(rule, message)
  	@parser = CronParser.new(rule)
  	@message = message
  end

  def pass?
  	next_time = @parser.next(Time.now)
  	if @before != next_time
      if @before.present?
        @before = next_time
        true
      else
        @before = next_time
        false
      end
    else
      false
  	end
  end
end