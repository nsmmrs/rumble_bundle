# The Scraper class will be responsible for finding the URLs to all available bundles, and parsing them into Bundle instances with Products.

class RumbleBundle::Scraper

  def initialize
    @base_url = 'https://www.humblebundle.com'
    @main_pages = [
      'https://www.humblebundle.com/',
      'https://www.humblebundle.com/books/',
      'https://www.humblebundle.com/mobile/']
  end

  def bundlize(page)
    doc = Nokogiri::HTML(open(page))

    # instantiate Bundle and Products
    RumbleBundle::Bundle.new.tap do |bundle|
      bundle.name = doc.css("title").text #minus "(pay what you want...)"
      bundle.charities = doc.css(".ch-image-wrapper img").collect{|img| img.attr("alt")}

      # #for each tier in bundle
      # doc.css(".main-content-row").each do |tier|

      #   #add tier to Bundle @tiers array
      #   bundle.tiers << tier.css(".dd-header-headline").text

      #   #instantiate products from tier
      #   RumbleBundle::Product.new.tap do |prod|
      #   end

      # end

    end

  end

end