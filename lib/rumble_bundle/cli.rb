class RumbleBundle::CLI
  # def initialize
  # end

  def self.start
    puts "Fetching data from HumbleBundle.com..."

    RumbleBundle::Scraper.new.crawl_site

    query

  end

  def self.query
    puts "Enter a bundle's number to learn more, or enter 'help' for more commands."
    puts "Enter 'quit' to leave the program."

    RumbleBundle::Bundle.all.each.with_index(1) do |bundle, i|
      puts "[#{i}] #{bundle.name}"
    end
  end

  def self.display(bundle)
  end

  def self.help
  end


end

