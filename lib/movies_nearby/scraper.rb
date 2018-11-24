class MoviesNearby::Scraper
  #https://www.moviefone.com/showtimes/bronx-ny/10458/theaters/
  attr_accessor :url

  def initialize(url)
   @url = url
  end
  def scrape
    theater_array = []
    doc = Nokogiri::HTML(open(url))
    theaters = doc.css("div.theater")
    theaters.each do |theater|
      times = theater.css("div.movie-listing").css(".showtimes-list")
      theater_hash = {}
      theater_hash[:movies] = []
      theater_hash[:times] = []
      theater_hash[:movies] << theater.css("div.movie-listing").css(".movietitle").text.gsub(/\(\d*\)/, " ").split("   ")
      theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      times.each {|time| theater_hash[:times] << time.text}
      theater_array << theater_hash
    end
    theater_array
  end

end
