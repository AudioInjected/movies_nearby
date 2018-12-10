class MoviesNearby::Movie
  @@all = []
  attr_accessor :title, :time, :url, :movie_info

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(movie_array)
    movies = []
    movie_array.each do |movie_hash|
    movies << MoviesNearby::Movie.new(movie_hash)
   end
   movies
  end
  
  def get_movie_info 
    self.movie_info = MoviesNearby::Scraper.scrape_movie_info(url)
  end
  
  def self.all 
    @@all
  end
end