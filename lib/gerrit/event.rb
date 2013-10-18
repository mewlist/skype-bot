#coding:utf-8

module Gerrit
  class Event
    attr_reader :verified, :reviewed
    def initialize(event)
      @event = event
      @verified = 'not set'
      @reviewed = 'not set'

      approvals.each { |a|
        case a["type"]
        when 'VRIF'
          @verified = a["value"]
        when 'CRVW'
          @reviewed = a["value"]
        end
      }
    end
    def type;      @event['type']              end
    def approvals; @event['approvals']||[{}]   end
    def change;    @event['change']||({})      end
    def project;   change['project']           end
    def branch;    change['branch']            end
    def uploader;  @event['uploader']['name']  end
    def author;    @event['author']['name']    end
    def owner;     change['owner']['name']     end
    def submitter; @event['submitter']['name'] end
    def subject;   change['subject']           end
    def url;       change['url']               end
    def comment;   @event['comment']||""       end
  end
end
