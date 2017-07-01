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

    RumbleBundle::Bundle.new.tap do |bundle|

      # Scrape Bundle metadata
      bundle.name = html.css("title").text.chomp("(pay what you want and help charity)").strip

      bundle.url = url

      bundle.charities = html.css(".charity-image-wrapper img").collect{|img| img.attr("alt")}

      bundle.total_msrp = html.css('.hr-tagline-text').detect{|e| e.text.include?("worth")}.text.strip



      bundle.tiers = Array.new.tap do |bundle_tiers|

        # Scrape Bundle page for Tiers
        html.css(".main-content-row").each do |row|

          # Stop iterating if scraper has reached a row which is not a Bundle Tier (row title will include "charity")
          row_title = row.css(".dd-header-headline").text.strip
          if row_title.downcase.include?("charity")
            break
          end

          # For each row, instantiate a Tier and add to the Bundle's @tiers array
          bundle_tiers << RumbleBundle::Tier.new.tap do |tier|
            tier.description = row_title
            # Associate Tier with Bundle
            tier.bundle = bundle

            # For each Tier, create an @products array, then instantiate Products and add them to the array
            tier.products = Array.new.tap do |tier_products|

              row.css(".game-boxes").each do |box|

                scrape_product(box, bundle, tier).tap do |product|
                  tier_products << product
                end
              end
            end

          end
        end
      end

    end
  end



  def scrape_product(box, bundle, tier)

    RumbleBundle::Product.new.tap do |product|

      product.bundle = bundle
      product.tier = tier

      product.name = box.css(".dd-image-box-caption").text.strip

      product.subtitle = if box.at_css(".subtitle")
        box.css(".subtitle .callout-msrp").remove
        if box.css(".subtitle").text.strip != ""
          box.css(".subtitle").text.strip
        else
          nil
        end
      end

      product.platforms = Array.new.tap do |platforms|
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

      product.drm_free = box.at_css(".dd-availability-icon > i.hb-drmfree") ?
        true : false

      product.steam_key = box.at_css(".dd-availability-icon > i.hb-steam") ?
        true : false

    end

  end

end