# ElapsedWatch

ElapsedWatch is a tiny command line script that will read an events
file and print out a nice, human-readable duration from or to the event.

## Installation

Add this line to your application's Gemfile:

    gem 'elapsed_watch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elapsed_watch

## Usage

Prints a short help message:

    $ elapsed_watch --help

Prints the elapsed time for events in `$HOME/.eventsrc`:

    $ elapsed_watch

Prints the elapsed time for events in `my_events`:

    $ elapsed_watch my_events

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
