class RumbleBundle::Bundle

  attr_accessor :name, :tiers, :charities, :total_msrp, :url
  attr_reader :products

  @@all = []

  def self.all
    @@all
  end

  def initialize
    self.class.all << self
  end

  def products
    self.tiers.collect{|t| t.products}.flatten
  end

end