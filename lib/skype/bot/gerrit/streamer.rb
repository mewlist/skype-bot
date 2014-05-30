#coding:utf-8

require 'json'
require 'active_support/core_ext'
require 'skype/bot/gerrit/event'
require 'net/ssh'

class Skype::Bot::Gerrit::Streamer
  attr_reader :config

  def listen_stream(config)
    @config = config
    open

    puts "gerrit project name    : #{@config.project}"
    puts "gerrit branch filter   : #{@config.branches.source}"
    puts "gerrit listening       : #{@config.user}@#{@config.host}:#{@config.port}"

    Thread.new do
      loop do
        begin
          listen do |data|
            event = Gerrit::Event.new( JSON.parse(data) )
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
            puts "#{event.type} @#{event.project}" if event.present?
          end
        rescue => e
          Bots::HelloBot.notify_error e

          close
          open
        end
      end
    end
  end

  def open
    @io = Net::SSH.start(@config.host, @config.user, port: @config.port)
  end

  def close
    @io.close
  end

  def listen
    @io.exec!("gerrit stream-events") do |channel, stream, data|
      if stream == :stderr
        puts "ERROR ON GERRIT STREAM EVENTS"
        puts data
        raise data
      end
      yield data
    end
  end

  # events
  def patched(event)
  end

  def reviewed(event)
  end

  def merged(event)
  end
end
