class MoviesNearby::Theater 
  @@all = []
  attr_accessor :name, :movies

  def initialize(theater_array)
    theater_array.each do |theater_hash|
    binding.pry
   end
  end
  
  def self.all 
    @@all
  end
  
end