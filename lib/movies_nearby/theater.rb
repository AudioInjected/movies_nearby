class MoviesNearby::Theater 
  @@all = []
  attr_accessor :name, :movies

  def initialize(theater_hash)
    theater_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(theater_array)
    theater_array.each do |theater_hash|
    MoviesNearby::Theater.new(theater_hash)
   end
  end
  
  def self.all 
    @@all
  end
  
  def search_for_movies
    MoviesNearby::Movie.all.each do |movie|
      if movie.theater_name == self.name 
        self.movies << movie
      end 
    end
  end
 
end