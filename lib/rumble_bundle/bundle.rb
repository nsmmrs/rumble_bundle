# Bundle instances will be responsible for knowing about a bundle and its included Products.

class RumbleBundle::Bundle

  attr_accessor :name, :tiers, :products, :charities

  @@all = []

  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end

  def initialize
    @tiers = []
    self.class.all << self
  end

end