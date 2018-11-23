class MoviesNearby::Scraper
  #https://www.moviefone.com/showtimes/bronx-ny/10458/theaters/
  attr_accessor :url

  def initialize(url)
   @url = url
  end
  def scrape
    theater_array = []
    doc = Nokogiri::HTML(open(url))
  #  theaters = doc.css("div.theater").css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
     theaters.each do |theater|
       theater_hash = {}
       theater_hash[:movies] = []
       #theater_hash[:times] = []
       theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
       theater_hash[:movies] << theater.css("div.movie-listing").css(".movietitle").text.gsub(/\(\d*\)/, " ").split("   ")
       theater_hash[:times] = theater.css("div.movie-listing").css(".showtimes-list").text
     end
    binding.pry
  end

end
