class RumbleBundle::CLI
  # def initialize
  # end

  def self.start
    puts ""
    puts "Fetching data from HumbleBundle.com..."
    puts ""

    RumbleBundle::Scraper.new.crawl_site
    bundles

    query

  end

  def self.bundles
    @@bundles ||= RumbleBundle::Bundle.all
  end

  def self.query
    puts ""
    puts "Enter a bundle's number to learn more, or enter 'help' for more commands."
    puts "Enter 'quit' to leave the program."
    puts ""

    bundles.each.with_index(1) do |bundle, i|
      puts "[#{i}] #{bundle.name}"
    end

    input = gets.strip
    if input.to_i.between?(1, bundles.length)
      display(bundles[input.to_i - 1])
    else
      case input
      when 'help'
        help
      when 'quit'
        quit
      # when 'help'
      # when 'drm-free'
      # when 'steam-key'
      # when 'windows'
      # when 'mac'
      # when 'linux'
      # when 'android'
      end


    end


  end

  def self.display(bundle)
    puts "I'm displaying #{bundle.name}!"
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
    puts "I'm quitting!"
  end

  def self.filter(arguments)
  end

end

