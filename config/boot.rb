#coding: utf-8
$:.unshift(File.expand_path(File.dirname(__FILE__)) + '/../config')
$:.unshift(File.expand_path(File.dirname(__FILE__)) + '/../lib')
require 'json'
require 'hashie'

class Boot
  class << self
    def configure
      @config ||= Hashie::Mash.new
      yield @config
    end

    def config
      @config
    end
  end
end
