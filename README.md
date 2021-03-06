# Blondie
...you've got to ask yourself one question: 'Do I feel lucky?' Well, with
blondie
take the luck out the draw. 🤠

Blondie is a tool to check your gemfile for any dependencies with C extensions
before bundling

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blondie'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install blondie

## Usage

Blondie takes an absolute path to a Gemfile, it then either provides a list of
the gems with C extensions or lets you know that none of your dependencies have
extensions

`blondie /path/to/Gemfile`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Brynbayliss87/blondie.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
