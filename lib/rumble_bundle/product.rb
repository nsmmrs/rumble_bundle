class RumbleBundle::Product

  attr_accessor :name, :subtitle, :bundle, :tier, :platforms, :drm_free, :steam_key

  @@all = []

  def self.all
    @@all
  end

  def initialize
    self.class.all << self
  end

end