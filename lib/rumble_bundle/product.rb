# Product instances will hold metadata for individual products, such as name, platform(s), or license

class RumbleBundle::Product

  attr_accessor :name, :subtitle, :bundle, :tier, :platforms, :drm, :steam_key

  def initialize(data)
    #accept data from Scraper
  end

end