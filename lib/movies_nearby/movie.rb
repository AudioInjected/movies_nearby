class MoviesNearby::Movies 
  @@all = []
  attr_accessor :name, :times, :urls, :movie_info

  def initialize(movie_hash)
    theater_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(movie_array)
    theater_array.each do |movie_hash|
    MoviesNearby::Movie.new(movie_hash)
   end
  end
  
  def self.all 
    @@all
  end
end