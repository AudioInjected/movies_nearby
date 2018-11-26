class MoviesNearby::CLI
  BASE = "https://www.moviefone.com/showtimes/"
  attr_accessor :borough, :zip_code, :url, :page_url

  def call
   greeting
   make_url
   theater_array = MoviesNearby::Scraper.new(self.url).scrape
   MoviesNearby::Theater.create_from_collection(theater_array)
   list_theaters
   movie_info
  end

  def greeting
    puts "Hello Welcome to Movies Nearby!"
    puts "Choose a borough and zip code to see what's playing nearby,"
    puts "Please enter a number corresponding to the borough or type exit to exit"
    puts "1:The Bronx   2:Manhattan   3:Brooklyn  4: Staten-Island  5:Queens"  
    @borough = borough_info
    puts "Please enter your zip code"
    @zip_code = zip_info
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
      
    elsif input.to_i == 3
      info = "brooklyn"
    elsif input.to_i == 4
      info = "staten-island"
     elsif input.to_i == 5
      info = "queens"  
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
    puts "Here are the theaters for #{self.zip_code} in #{self.borough.capitalize} NY"
    puts
    MoviesNearby::Theater.all.each.with_index(1) {|theater, index| puts "#{index}: #{theater.name}"}
    puts
    puts "Please enter one of the choices for more details:"
    input = gets.strip
    index = input.to_i - 1
    theater = MoviesNearby::Theater.all[index]
    puts theater.name
    theater.movies.each.with_index(1) {|movie, index| puts "#{index}: #{movie}: #{theater.times[index - 1].tr("m", " ")}"}
    puts "Please enter one of the choices for more details on the movie"
    input = gets.strip
    index = input.to_i - 1
    self.page_url = theater.urls[index]
  end
  
  def movie_info
   MoviesNearby::Scraper.new(self.page_url).scrape_movie_page
  end
end
