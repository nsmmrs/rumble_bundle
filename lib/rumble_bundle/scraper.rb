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
      bundle.name = doc.css("title").text.chomp("(pay what you want and help charity)").strip
      bundle.charities = doc.css(".charity-image-wrapper img").collect{|img| img.attr("alt")}

      #for each tier in bundle
      doc.css(".main-content-row")[0..-3].each do |tier|

        #add tier to Bundle @tiers array
        tier_name = tier.css(".dd-header-headline").text.strip
        bundle.tiers << tier_name

        #instantiate products from tier
        tier.css(".game-boxes").each do |box|

          RumbleBundle::Product.new.tap do |product|
            product.name = box.css(".dd-image-box-caption").text.strip

            if box.at_css(".subtitle")
              box.css(".subtitle .callout-msrp").remove
              unless box.css(".subtitle").text.strip == ""
                product.subtitle = box.css(".subtitle").text.strip
              end
            end

            product.bundle = bundle.name

            product.tier = tier_name

            bundle.products << product

          end

        end


      end

    end

  end

end