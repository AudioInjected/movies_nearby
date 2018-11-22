class MoviesNearby::CLI
  BASE = "https://www.moviefone.com/showtimes/"
  attr_accessor = :borough, :zip_code, :url
  def call
   greeting
  end

  def greeting
    puts "Hello Welcome to Movies Nearby!"
    puts "Choose a borough and zip code to see what's playing nearby,"
    puts "Please enter a number corresponding to the borough or type exit to exit"
    puts "1:The Bronx   2:Manhattan"
    @borough = "bronx"
    puts "Please enter your zip code"
    @zip_code = "10453"
  end

  def make_url
    @url = BASE + @borough + "-ny/" + @zip_code + "/theaters/"
  end



#  def info
#   info = gets.strip
  #  until info.to_i > 0 || info == "exit"
  #    puts "Please enter a valid number or type exit"
  #    info = gets.strip
  #  end
  #  info
  #end
end
