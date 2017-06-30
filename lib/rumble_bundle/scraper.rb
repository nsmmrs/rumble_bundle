class RumbleBundle::Scraper

  def initialize
    @base_url = 'https://www.humblebundle.com'
    @main_pages = [
      'https://www.humblebundle.com/',
      'https://www.humblebundle.com/books/',
      'https://www.humblebundle.com/mobile/']
  end



  def crawl_site
    @main_pages.each do |page|
      first_page = Nokogiri::HTML(open(page))
      scrape_bundle(first_page, page)

      if first_page.at_css(".js-highlight.subtab-button")
        tab_bar = first_page.css(".js-highlight.subtab-button")
        links = tab_bar.collect{|a| @base_url + a.attr("href") }

        links.each do |link|
          scrape_bundle(Nokogiri::HTML(open(link)), link)
        end
      end
    end

  end



  def scrape_bundle(html, url)

    bundle = {
      'name' => '',
      'tiers' => [],
      'products' => [],
      'charities' => [],
      'total_msrp' => '',
      'url' => url
    }

    bundle['name'] = html.css("title").text.chomp("(pay what you want and help charity)").strip

    bundle['charities'] = html.css(".charity-image-wrapper img").collect{|img| img.attr("alt")}

    #for each tier in bundle
    html.css(".main-content-row")[0..-3].each do |tier|

      #add tier to Bundle @tiers array
      tier_name = tier.css(".dd-header-headline").text.strip
      bundle['tiers'] << tier_name

      #instantiate products from tier
      tier.css(".game-boxes").each do |box|
        scrape_product(box, tier_name).tap do |product|
          bundle['products'] << product
        end
      end

    end

    bundle['total_msrp'] = html.css('.hr-tagline-text').detect{|e| e.text.include?("worth")}.text.strip

    RumbleBundle::Bundle.new(bundle)

  end



  def scrape_product(box, tier)

    product = {
      'name' => '',
      'subtitle' => '',
      'bundle' => '',
      'tier' => '',
      'platforms' => [],
      'drm_free' => nil,
      'steam_key' => nil
    }

    product['name'] = box.css(".dd-image-box-caption").text.strip
    product['tier'] = tier
    product['subtitle'] = if box.at_css(".subtitle")
      box.css(".subtitle .callout-msrp").remove
      if box.css(".subtitle").text.strip != ""
        box.css(".subtitle").text.strip
      else
        nil
      end
    end

    product['platforms'] = Array.new.tap do |platforms|
      if box.at_css(".dd-availability-icon > i.hb-android")
        platforms << 'Android'
      end

      if box.at_css(".dd-availability-icon > i.hb-linux")
        platforms << 'Linux'
      end

      if box.at_css(".dd-availability-icon > i.hb-windows")
        platforms << 'Windows'
      end

      if box.at_css(".dd-availability-icon > i.hb-osx")
        platforms << 'Mac'
      end

    end

    product['drm_free'] = box.at_css(".dd-availability-icon > i.hb-drmfree") ?
      true : false

    product['steam_key'] = box.at_css(".dd-availability-icon > i.hb-steam") ?
      true : false

    RumbleBundle::Product.new(product)

  end

end