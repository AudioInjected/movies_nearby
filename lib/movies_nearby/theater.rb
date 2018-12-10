class MoviesNearby::Theater 
  @@all = []
  attr_accessor :name, :movies

  def initialize(theater_hash)
   self.name = theater_hash[:name]
   self.movies = []
   
   self.movies << MoviesNearby::Movie.create_from_collection(theater_hash[:movies]).all
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
  
end