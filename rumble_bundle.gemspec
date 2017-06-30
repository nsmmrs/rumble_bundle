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
  spec.homepage      = "https://github.com/repromancer/rumble_bundle"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables  << 'rumble_bundle'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri", "~> 1.7"
end
