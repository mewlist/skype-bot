#!/usr/bin/env ruby
#coding:utf-8

require File.expand_path(File.dirname(__FILE__)) + '/../config/boot.rb'
require 'config'
require 'skype/bot'

include Skype::Bot

gerrit_bot_thread = Bots::GerritBot.new.listen_stream(Boot.config)

gerrit_bot_thread.join
