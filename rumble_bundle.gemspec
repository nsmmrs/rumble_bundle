# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rumble_bundle/version"

Gem::Specification.new do |spec|
  spec.name          = "rumble_bundle"
  spec.version       = RumbleBundle::VERSION
  spec.authors       = ["Noah Summers"]
  spec.email         = ["connect@repromancer.me"]

  spec.summary       = %q{Simple command line reader for the Humble Bundle website.}

  spec.description   = %q{This is a rudimentary info scraper and command line "browser" for the Humble Bundle website, using plain Ruby and Nokogiri.

  Upon firing up, it will scrape the Game Bundles, Book Bundles, and Mobiles Bundles tabs (along with any sub-tabs) for ongoing bundles. Once it's finished, you can query the scraped information via the command prompt.

  Available information for each bundle includes: Name, Supported Charities, Donation Tiers and Included Products, Total MSRP, and URL.

  Available products can also be filtered by tags like linux, or drm-free, or multiple at once (windows linux drm-free).}

  spec.homepage      = "https://github.com/repromancer/rumble_bundle"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables  << 'rumble_bundle'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri", "~> 1.7"
end
