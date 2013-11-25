#!/usr/bin/env ruby
#coding:utf-8

require File.expand_path(File.dirname(__FILE__)) + '/../config/boot.rb'
require 'config'
require 'skype/bot'

include Skype::Bot

Thread.abort_on_exception = true

def start
  Bots::HelloBot.hello

  Bots::GerritBot.new.listen_stream(Boot.config.gerrit)
  Bots::FeedsBot.new.listen(Boot.config.feeds)
  Bots::AzmsBot.new.listen
  Bots::StewardBot.new.listen(Boot.config.steward)

  sleep
end

loop do
  begin
    start
  rescue => e
    tracelog = e.backtrace.join("\n")
    STDERR.puts tracelog
    Bots::HelloBot.goodbye tracelog
    sleep 1
  end
end