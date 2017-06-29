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

  def initialize(data)
    @tiers = []
    @products = []
    @charities = []

    data.each{|key, val| self.send("#{key}=", val)}
    self.class.all << self
  end

end