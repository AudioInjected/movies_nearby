class MoviesNearby::CLI
  BASE = "https://www.moviefone.com/showtimes/"
  attr_accessor = :borough, :zip_code, :url

  def call
   greeting
   make_url
   theater_array = MoviesNearby::Scraper.new(self.url).scrape
   MoviesNearby::Theater.create_from_collection(theater_array)
  end

  def greeting
    puts "Hello Welcome to Movies Nearby!"
    puts "Choose a borough and zip code to see what's playing nearby,"
    puts "Please enter a number corresponding to the borough or type exit to exit"
    puts "1:The Bronx   2:Manhattan"
    @borough = borough_info
    puts "Please enter your zip code"
    @zip_code = zip_info
  end

  def borough
    @borough
  end

  def zip_code
    @zip_code
  end
  def url
    @url
  end

  def make_url
    @url = BASE + @borough + "-ny/" + @zip_code + "/theaters/"
  end

  def borough_info
   input = gets.strip
    until input.to_i > 0 || input == "exit"
      puts "Please enter a valid number or type exit"
      input = gets.strip
    end
    if input.to_i == 1
      info = "bronx"
    elsif input.to_i == 2
      info = "manhattan"
   end
   info
  end

  def zip_info
    input = gets.strip
    until input.to_i.is_a?(Integer) && input.length == 5 || input == "exit"
      puts "Please enter a valid zip_code or type exit"
      input = gets.strip
    end
      input
  end

  def list_theaters
    puts "Here are the theaters for #{self.zip_code} in #{self.borough} NY"
    puts Theater.all.each_with_index(1) {|element, index| puts "#{index}: #{element}"}
  end
end
