class MoviesNearby::Movie
  @@all = []
  @all = []
  attr_accessor :movies, :times, :urls, :movie_info, :theater_name

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(movie_array)
    movie_array.each do |movie_hash|
    MoviesNearby::Movie.new(movie_hash)
   end
  end
  
  def get_movie_info(url) 
    @movie_info << MoviesNearby::Scraper.scrape_movie_info(url)
  end
  
  def self.all 
    @@all
  end
end