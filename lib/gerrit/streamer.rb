#coding:utf-8

require 'json'
require 'gerrit/event'

module Gerrit
  class Streamer
    attr_reader :config

    def listen_stream(config)
      @config = config
      @io = open

      puts "project name    : #{@config.project}"
      puts "branch filter   : #{@config.branches.source}"
      puts "listening       : #{@config.user}@#{@config.host}:#{@config.port}"
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
          puts "#{event.type} @#{event.project}"
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
end