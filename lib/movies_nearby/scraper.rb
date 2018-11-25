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
      urls = theater.css("div.movie-listing a")
      theater_hash = {}
      #theater_hash[:movies] = []
      theater_hash[:times] = []
      theater_hash[:urls] = []
      theater_hash[:movies] = theater.css("div.movie-listing").css(".movietitle").text.gsub(/\(\d*\)/, " ").split("   ")
      theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      urls.each {|url| theater_hash[:urls] << url.attributes["href"].value}
      theater_hash[:urls].uniq!
      #binding.pry
      times.each {|time| theater_hash[:times] << time.text}
      theater_array << theater_hash
    end
    theater_array
  end
  
  def scrape_movie_page(url)
    movie = Nokogiri::HTML(open(url))
    puts movie.xpath("//*[@id='movie-overview']/div/div/div[2]/p[3]/text()")
  end

end
