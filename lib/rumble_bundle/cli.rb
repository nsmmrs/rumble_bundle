class RumbleBundle::CLI
  # def initialize
  # end

  def self.start
    puts ""
    puts "Fetching data from HumbleBundle.com..."
    puts ""

    RumbleBundle::Scraper.new.crawl_site

    query

  end

  def self.query
    puts ""
    puts "Enter a bundle's number to learn more, or enter 'help' for more commands."
    puts "Enter 'quit' to leave the program."

    bundles = RumbleBundle::Bundle.all

    bundles.each.with_index(1) do |bundle, i|
      puts "[#{i}] #{bundle.name}"
    end

    input = gets.strip
    if input.to_i.between?(1, bundles.length)
      binding.pry
      display(bundles[input.to_i - 1])
    # else
    #   case input
    #   when 'help'
    #     help
    #   when 'quit'
    #     quit
      # when 'help'
      # when 'drm-free'
      # when 'steam-key'
      # when 'windows'
      # when 'mac'
      # when 'linux'
      # when 'android'
      # end


    end


  end

  def self.display(bundle)
    puts "I'm displaying #{bundle.name}!"
  end

  def self.help
  end

  def self.quit
  end

  def self.filter(arguments)
  end

end

