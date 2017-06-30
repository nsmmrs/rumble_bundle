# RumbleBundle

This is a rudimentary info scraper and command line "browser" for the Humble Bundle website, using plain Ruby and Nokogiri.

Upon firing up, it will scrape the Game Bundles, Book Bundles, and Mobiles Bundles tabs (along with any sub-tabs) for ongoing bundles. Once it's finished, you can query the scraped information via the command prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rumble_bundle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rumble_bundle

## Usage

Install via `$ gem install rumble_bundle`
Run via     `$ rumble_bundle`

Then follow the on-screen prompt. :)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/repromancer/rumble_bundle.
