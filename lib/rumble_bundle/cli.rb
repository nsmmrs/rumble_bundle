class RumbleBundle::CLI

  # Scrape site and allow user to begin browsing.
  def start
    puts
    puts "Fetching data from HumbleBundle.com..."
    puts

    RumbleBundle::Scraper.new.crawl_site

    query

  end



  def query

    bundles = RumbleBundle::Bundle.all

    puts
    puts "Enter a bundle's number to learn more, or enter 'help' for more commands."
    puts "Enter 'quit' to leave the program."
    puts

    # List Bundles in numbered order
    bundles.each.with_index(1) do |bundle, i|
      puts "[#{i}] #{bundle.name}"
    end

    # Get user input
    puts
    print " "
    input = gets.strip.downcase
    puts

    # If input is a valid number, display the corresponding Bundle
    if input.to_i.between?(1, bundles.length)
      display_bundle(bundles[input.to_i - 1])

    # If input is an invalid number, restart #query
    elsif input.to_i < 0 || input.to_i > bundles.length
      puts
      puts "Sorry! Please enter a valid number or command."
      query

    # Check for 'help' or 'quit' commands, else pass input to #filter
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
    # Compare input to recognized tags
    filters = %w[drm-free steam-key windows mac linux android]
    valid = filters & input.split

    # If input is valid, collect an array of all Products, remove any that do not match search tags, then display results in a formatted list
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
        puts
        puts "Results for: #{valid}"
        puts "---------------------------------------------------------------"
        filtered.collect{|p| p.bundle }.uniq.each do |bundle|
          puts "#{bundle.name} (#{bundle.url})"
          puts
          bundle.tiers.each do |tier|
            if filtered.detect{|p| p.tier == tier}
              puts "  #{tier.description}"
              puts
              filtered.each{|p| display_product(p) if p.tier == tier}
              puts
            end
          end
        end
        puts "---------------------------------------------------------------"
      else
        puts
        puts "Sorry! No results for: #{valid}"
        puts "---------------------------------------------------------------"
        puts "---------------------------------------------------------------"
      end

    else
      puts
      puts "Sorry! Please enter a valid number or command."
      query

    end

    query

  end



  # Display formatted information for given Bundle
  def display_bundle(bundle)
    puts "---------------------------------------------------------------"
    puts "#{bundle.name} (#{bundle.url})"
    puts
    puts "#{bundle.total_msrp}!"
    puts
    puts bundle.charities
    puts
    puts
    bundle.tiers.each do |tier|
      puts "  #{tier.description}"
      puts
      tier.products.each{|p| display_product(p)}
      puts
    end
    puts "---------------------------------------------------------------"

    query
  end

  def display_product(product)
    print "    #{product.name}"
    print " (#{product.platforms.join(", ")})" if product.platforms.any?
    print " (DRM-Free!)" if product.drm_free
    print " (w/Steam Key!)" if product.steam_key
    puts
    puts "      #{product.subtitle}" if product.subtitle
    puts
  end

  # Display help
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

  # Quit
  def quit
    exit
  end

end

