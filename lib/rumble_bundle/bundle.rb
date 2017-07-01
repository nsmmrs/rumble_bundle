class RumbleBundle::Bundle

  attr_accessor :name, :tiers, :products, :charities, :total_msrp, :url

  @@all = []

  def self.all
    @@all
  end

  def initialize
    self.class.all << self
  end



end