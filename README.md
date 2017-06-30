# RumbleBundle

This is a rudimentary info scraper and command line "browser" for the [Humble Bundle](https://www.humblebundle.com/) website, using plain Ruby and Nokogiri.

Upon firing up, it will scrape the Game Bundles, Book Bundles, and Mobiles Bundles tabs (along with any sub-tabs) for ongoing bundles. Once it's finished, you can query the scraped information via the command prompt.

Available information for each bundle includes: Name, Supported Charities, Donation Tiers and Included Products, Total MSRP, and URL.

Available products can also be filtered by tags like `linux`, or `drm-free`, or multiple at once (`windows linux drm-free`).

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

Install via:
```$ gem install rumble_bundle```

Run via:
```$ rumble_bundle```

Then follow the on-screen prompts. :)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/repromancer/rumble_bundle.
