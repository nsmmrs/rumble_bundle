class RumbleBundle::CLI

  def start
    puts ""
    puts "Fetching data from HumbleBundle.com..."
    puts ""

    RumbleBundle::Scraper.new.crawl_site

    query

  end


  def query

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
    elsif input.to_i < 0 || input.to_i > bundles.length
      puts ""
      puts "Sorry! Please enter a valid number or command."
      query

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

  def filter(input)
    filters = %w[drm-free steam-key windows mac linux android]
    valid = filters & input.split
    if valid.any?
      filtered = RumbleBundle::Product.all.collect{|p| p}
      valid.each do |filter|
        case filter
        when 'windows','mac','linux','android'
          filtered.delete_if{|p| ! p.platforms.include?(filter.capitalize)}
        when 'drm-free'
          filtered.delete_if{|p| ! p.drm_free}
        when 'steam-key'
          filtered.delete_if{|p| ! p.steam_key}
        end
      end

      if filtered.any?
        puts ""
        puts "Results for: #{valid}"
        puts "---------------------------------------------------------------"
        filtered.collect{|p| p.bundle }.uniq.each do |bundle|
          puts "#{bundle.name} (#{bundle.url})"
          puts ""
          filtered.each{|p| display_product(p) if p.bundle == bundle}
          puts ""
        end
        puts "---------------------------------------------------------------"
      else
        puts ""
        puts "Sorry! No results for: #{valid}"
        puts "---------------------------------------------------------------"
        puts "---------------------------------------------------------------"
      end

    else
      puts ""
      puts "Sorry! Please enter a valid number or command."
      query

    end

    query

  end

  def display_bundle(bundle)
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
      puts tier.description, ""
      tier.products.each{|p| display_product(p)}
      puts ""
    end
    puts "---------------------------------------------------------------"

    query
  end

  def display_product(product)
    print "  #{product.name}"
    print " (#{product.platforms.join(", ")})" if product.platforms.any?
    print " (DRM-Free!)" if product.drm_free
    print " (w/Steam Key!)" if product.steam_key
    puts ""
    puts "    #{product.subtitle}" if product.subtitle
    puts ""
  end

  def help
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

  def quit
    exit
  end

end

