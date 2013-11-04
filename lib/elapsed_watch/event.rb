=begin rdoc

event.rb -- defines the Class ElapsedWatch::Event for holding events

* Time-stamp: <2013-11-04 06:26:02 tamara>
* Copyright (C) 2013 Tamara Temple Web Development
* Author:     Tamara Temple <tamouse@gmail.com>
* License:    MIT

=end


require 'chronic'
require 'chronic_duration'
require 'yaml'
require 'erb'
require 'time'
require 'methadone'

module ElapsedWatch

  # The format for events occuring in the past
  PAST_EVENT_FORMAT = "%s %s ago"

  # The format for events occuring in the future
  FUTURE_EVENT_FORMAT = "%s in %s"    


  # == Description
  #
  # Defines an object class that deals with individual events.
  #
  # Events have a name and a time.
  class Event 
    
    include Methadone::CLILogging

    # Instantiates a new Event object.
    #
    # The event_string consists of a tiny piece of YAML that defines
    # the event. The format is:
    #
    # Event Name: YYYY-MM-DD HH:MM (anything parsable by Chronic.parse)
    def initialize(event_string)
      raise "event_string is empty" if event_string.nil? or event_string.empty?
      ev_yaml = YAML.load(ERB.new(event_string).result)
      @event_name = ev_yaml.keys.first
      @event_time = ev_yaml.values.first
      raise "No event time spec: #{event_string}" if @event_time.nil?
      case @event_time
      when String
        raise "No event time spec: #{event_string}" if @event_time.empty?
        @event_time = Chronic.parse(@event_time)
      when Date
        @event_time = @event_time.to_time
      when DateTime
        @event_time = @event_time.to_time
      when Integer
        @event_time = Time.new @event_time
      when nil

      end
    end

    # Returns a formatted string for the event
    def to_s()
      format() % [@event_name, duration_string()]
    end

    alias :duration :to_s

    # Returns a nicely formatted string of the duration between the
    # event and now
    def duration_string()
      ChronicDuration.output(time_diff())
    end

    # Calculates the absolute value of the difference between the
    # event and now
    def time_diff()
      (now() - @event_time).to_i.abs
    end

    # Returns the format string to use based on whether the event is
    # in the past or the future.
    def format()
      if now() >= @event_time
        PAST_EVENT_FORMAT
      else
        FUTURE_EVENT_FORMAT
      end
    end

    # Parse an event sting and return an event object
    def self.parse(event_string)
      self.new(event_string)
    end

    private
    
    # Memoizes now
    def now(use_time=nil)
      @now ||= use_time ||= Time.now
    end

  end

end
