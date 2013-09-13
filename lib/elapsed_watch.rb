=begin rdoc

elapsed_watch.rb -- show human readable time since or until a set of events

* Time-stamp: <2013-09-13 02:14:05 tamara>
* Copyright (C) 2013 Tamara Temple Web Development
* Author:     Tamara Temple <tamouse@gmail.com>
* License:    MIT

=end

require "elapsed_watch/version"
require "elapsed_watch/event"
require "elapsed_watch/event_collection"

module ElapsedWatch

  # Module method that runs the elapsed watcher
  #
  # == Inputs
  # * event_file (string) - name of the event file, nil to use default
  # * options (hash) - options from command line
  #
  # == Returns
  # Array of elapsed times for events
  def self.run(event_file,options={})
    EventCollection.new(event_file).map(&:to_s)
  end

end
