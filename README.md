# LoggerPlus

LoggerPlus adds splats to the various log levels provided in `ruby/logger`, and reformats the messages to a hash representation, allowing for simple migration to a JSON logger.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logger_plus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logger_plus

## Usage

LoggerPlus extends ::Logger directly, so extend LoggerPlus or use as a direct dropin for ::Logger.
LoggerPlus will also intelligently extend LogStashLogger's MultiLogger, which allows it to play nicely with LogStashLogger.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Negotiatus/logger_plus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LoggerPlus project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Negotiatus/logger_plus/blob/master/CODE_OF_CONDUCT.md).
