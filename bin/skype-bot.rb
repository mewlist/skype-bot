#!/usr/bin/env ruby
#coding:utf-8

require File.expand_path(File.dirname(__FILE__)) + '/../config/boot.rb'
require 'config'
require 'skype/bot'

include Skype::Bot

[
  Bots::GerritBot.new.listen_stream(Boot.config.gerrit),
  Bots::FeedBot.new.listen(Boot.config.feed),
].each do |thread|
  thread.join
end
