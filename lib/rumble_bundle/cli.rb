class RumbleBundle::CLI

  def self.start
    puts ""
    puts "Fetching data from HumbleBundle.com..."
    puts ""

    RumbleBundle::Scraper.new.crawl_site

    query

  end


  def self.query

    bundles = RumbleBundle::Bundle.all

    puts ""
    puts "Enter a bundle's number to learn more, or enter 'help' for more commands."
    puts "Enter 'quit' to leave the program."
    puts ""

    bundles.each.with_index(1) do |bundle, i|
      puts "[#{i}] #{bundle.name}"
    end

    puts ""
    print " "
    input = gets.strip.downcase
    puts ""

    if input.to_i.between?(1, bundles.length)
      display_bundle(bundles[input.to_i - 1])
    else
      case input
      when 'help'
        help
      when 'quit'
        quit
      else
        filter(input)
      end
    end

  end

  def self.filter(input)
    filters = %w[drm-free steam-key windows mac linux android]
    valid = filters & input.split
    if valid.any?
      filtered = RumbleBundle::Product.all.collect{|p| p}
      valid.each do |filter|
        case filter
        when 'windows','mac','linux','android'
          # binding.pry
          filtered.delete_if{|p| ! p.platforms.include?(filter.capitalize)}
        when 'drm-free'
          filtered.delete_if{|p| ! p.drm_free}
        when 'steam-key'
          filtered.delete_if{|p| ! p.steam_key}
        end
      end

      # bundles = filtered.collect{|p| p.bundle }.uniq



      filtered.each{|p| puts p.name}

    end

    query

  end

  def self.display_bundle(bundle)
    puts "---------------------------------------------------------------"
    puts "#{bundle.name} (#{bundle.url})"
    puts "#{bundle.total_msrp}!"
    puts ""
    puts "Supports:"
    bundle.charities.each do |c|
      print "  #{c}"
      puts ","
    end
    puts "  or a Charity of Your Choice"
    puts "", ""
    bundle.tiers.each do |tier|
      puts tier, ""
      bundle.products.each do |product|
        if product.tier == tier
          display_product(product)
        end
      end
      puts ""
    end
    puts "---------------------------------------------------------------"

    query
  end

  def self.display_product(product)
    print "  #{product.name}"
    print " (#{product.platforms.join(", ")})" if product.platforms.any?
    print " (DRM-Free!)" if product.drm_free
    print " (w/Steam Key!)" if product.steam_key
    puts ""
    puts "    #{product.subtitle}" if product.subtitle
    puts ""
  end

  def self.help
    puts <<~HEREDOC
    ---------------------------------------------------------------
    You can enter a filter to list all products matching that filter.
    You can combine multiple filters in a space-separated list.

      e.g. 'drm-free linux'

    drm-free
    steam-key
    windows
    mac
    linux
    android

    Press any key to continue.
    ---------------------------------------------------------------
    HEREDOC
    STDIN.getch
    query
  end

  def self.quit
    exit
  end

end

