class MoviesNearby::Theater 
  @@all = []
  attr_accessor :name, :movies, :times

  def initialize(theater_hash)
    theater_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(theater_array)
    theater_array.each do |theater_hash|
    theater = MoviesNearby::Theater.new(theater_hash)
   end
  end
  
  def self.all 
    @@all
  end
  
  def self.reset!
    @@all.clear
  end
 
end

hash_array = [{name: "Test", movies: "some movies", times: "9:00pm"},{name: "Test2", movies: "some movies2", times: "11:00pm"} ]