class MoviesNearby::CLI
  BASE = "https://www.moviefone.com/showtimes/"

  def call
   greeting
   make_url
   create_theaters_movies
   start
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
 
 def start 
   list_theaters
   list_movie_info
   puts "Do you want to continue? Yes: No:"
   input = gets.strip 
   if input.downcase.include?("y")
     start 
   else 
     puts "Thank you for using Movies Nearby."
   end
 end

  def make_url
    @url = BASE + @borough + "-ny/" + @zip_code + "/theaters/"
  end

  def borough_info
   input = gets.strip
   until input.to_i > 0  && input.to_i <= 5|| input == "exit"
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
  
  def create_theaters_movies
   MoviesNearby::Scraper.create_doc(@url)
   @theater_array = MoviesNearby::Scraper.scrape_theater
   MoviesNearby::Theater.create_from_collection(@theater_array)
  end

  def list_theaters
    puts "Here are the theaters for #{@zip_code} in #{@borough.capitalize} NY"
    puts
    MoviesNearby::Theater.all.each.with_index(1) {|theater, index| puts "#{index}: #{theater.name}"}
    puts
    puts "Please enter one of the choices for more details:"
    input = gets.strip
    until input.to_i > 0 && input.to_i <= MoviesNearby::Theater.all.length
      puts "Please enter a valid number"
      input = gets.strip
    end
    index = input.to_i - 1
    @theater = MoviesNearby::Theater.all[index]
    puts @theater.name
    @theater.movies.each.with_index(1) {|movie, index| puts "#{index}: #{movie.title}: #{movie.time.tr("m", " ").strip}"}
    puts
    puts "Please enter one of the choices for more details on the movie"
    input = gets.strip
    until input.to_i > 0 && input.to_i <= @theater.movies.length
     puts "Please enter a valid number"
     input = gets.strip
    end
    @movie_index = input.to_i - 1
  end
  
  def list_movie_info
    if !@theater.movies[@movie_index].movie_info
     @theater.movies[@movie_index].get_movie_info
    end
     movie = @theater.movies[@movie_index].movie_info
     puts "********Movie Info********"
     puts
     puts "#{movie[:title]}"
     puts "#{movie[:release_date]}"
     puts "#{movie[:rating]}"
     puts "#{movie[:description]}"
     puts
  end
  
end



