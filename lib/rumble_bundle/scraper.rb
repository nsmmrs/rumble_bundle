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
    # scrape page for bundle information
    # instantiate Bundle and Products
  end

end