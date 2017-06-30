class RumbleBundle::Bundle

  attr_accessor :name, :tiers, :products, :charities, :total_msrp, :url

  @@all = []

  def self.all
    @@all
  end

  def initialize(data_hash)
    data_hash.each{|key, val| self.send("#{key}=", val)}
    self.class.all << self
  end



  def products=(array)

    #associate incoming products with Bundle
    @products = array.tap do |products|
      products.each do |product|
        product.bundle = self
      end
    end

  end

end