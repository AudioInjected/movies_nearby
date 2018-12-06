class MoviesNearby::Scraper
# https://www.moviefone.com/showtimes/staten-island-ny/10302/theaters/

  def self.scrape_theater(url)
    @doc = Nokogiri::HTML(open(url))
    theaters = doc.css("div.theater")
    theater_array = []
    theaters.each do |theater|
      theater_hash = {}
      theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      theater_array << theater_hash
    end
    theater_array
  end
  
  def self.scrape_movie(url)
    times = theater.css("div.movie-listing").css(".showtimes-list")
    urls = theater.css(".moviePoster a")
    binding.pry
  end
  
  def self.scrape_movie_info(url)
 
  end

end
