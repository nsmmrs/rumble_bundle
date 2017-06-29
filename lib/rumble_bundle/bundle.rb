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

  def initialize(data_hash)
    # @tiers = []
    # @products = []
    # @charities = []

    data_hash.each{|key, val| self.send("#{key}=", val)}
    self.class.all << self
  end

  def products=(array)

    #associate incoming products with Bundle
    @products = array.tap do |products|
      products.each do |product|
        product.bundle = self.name
      end
    end

  end

end