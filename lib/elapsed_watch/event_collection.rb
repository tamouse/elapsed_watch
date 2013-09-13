module ElapsedWatch

  DEFAULT_EVENT_FILE = File.join(ENV['HOME'],'.eventsrc')

=begin rdoc

event_collection.rb -- a collection of events to process

* Time-stamp: <2013-09-13 01:44:46 tamara>
* Copyright (C) 2013 Tamara Temple Web Development
* Author:     Tamara Temple <tamouse@gmail.com>
* License:    MIT

=end

  # The event collection holds all the events to watch.
  class EventCollection < Array
    
    # Set up the EventCollection by passing in a file name that
    # contains the events. If omitted or nil, the default file name at
    # $HOME/.eventsrc will be used. 
    def initialize(event_file_name=nil)
      self.event_file = event_file_name ||= DEFAULT_EVENT_FILE
    end

    # Get the event file name
    def event_file()
      @event_file
    end

    # Assign the event file name and reload the contents of the file
    def event_file=(fn)
      @event_file=fn
      self.reload()
    end

    # Reload the events from the event file. Existing events are
    # deleted first.
    def reload()
      self.clear
      self.concat File.read(event_file).split(/\r?\n/).map{|e| Event.new(e)}
    end

  end

end
