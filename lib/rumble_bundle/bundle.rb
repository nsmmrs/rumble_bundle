class RumbleBundle::Bundle

  attr_accessor :name, :url, :tiers, :charities, :total_msrp

  @@all = []

  def self.all
    @@all
  end

  def initialize
    self.class.all << self
  end

  def products
    # Leverage Bundle#tiers to expose a flat array of a Bundle's Products.
    self.tiers.collect{|t| t.products}.flatten
  end

end