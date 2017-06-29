# Product instances will hold metadata for individual products, such as name, platform(s), or license

class RumbleBundle::Product

  attr_accessor :name, :subtitle, :bundle, :tier, :platforms, :drm, :steam_key

  @@all = []

  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end

  def initialize
    self.class.all << self
  end

end