class MoviesNearby::CLI 
  BASE = "https://www.moviefone.com/showtimes/"
  attr_accessor = :borough, :zip_code
  def call
   greeting
   
  end
  
  def greeting 
    puts "Hello Welcome to Movies Nearby!"
    puts "Choose a borough and zip code to see what's playing nearby,"
    puts "Please enter a number corresponding to the borough or type exit to exit"
    puts "1:The Bronx   2:Manhattan"
    @borough = "Bronx"
  end
  
  def borough
    @borough
  end
  
  
  #def info 
 #   @borough = gets.strip
  #  until 
 # end
end
