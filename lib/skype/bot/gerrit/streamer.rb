#coding:utf-8

require 'json'
require 'active_support/core_ext'
require 'skype/bot/gerrit/event'

class Skype::Bot::Gerrit::Streamer
  attr_reader :config

  def listen_stream(config)
    @config = config
    @io = open

    puts "gerrit project name    : #{@config.project}"
    puts "gerrit branch filter   : #{@config.branches.source}"
    puts "gerrit listening       : #{@config.user}@#{@config.host}:#{@config.port}"

    Thread.new do
      loop do
        begin
          event = Gerrit::Event.new( JSON.parse(@io.gets) )
          if event.project == @config.project && event.branch.match(@config.branches)
            case event.type
            when 'patchset-created'
              patched event
            when 'comment-added'
              reviewed event
            when 'change-merged'
              merged event
            end
          end
        rescue
          @io = open
        ensure
          puts "#{event.type} @#{event.project}" if event.present?
        end
      end
    end
  end

  def open
    IO.popen("ssh -p #{@config.port} #{@config.user}@#{@config.host} gerrit stream-events")
  end

  # events
  def patched(event)
  end

  def reviewed(event)
  end

  def merged(event)
  end
end
