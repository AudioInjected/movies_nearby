class MoviesNearby::Scraper
  #https://www.moviefone.com/showtimes/bronx-ny/10458/theaters/

  def self.scrape(url)
    theater_array = []
    doc = Nokogiri::HTML(open(url))
    theaters = doc.css("div.theater")
    theaters.each do |theater|
      times = theater.css("div.movie-listing").css(".showtimes-list")
      urls = theater.css(".moviePoster a")
      theater_hash = {}
      #theater_hash[:movies] = []
      theater_hash[:times] = []
      theater_hash[:urls] = []
      theater_hash[:movies] = theater.css("div.movie-listing").css(".movietitle").text.gsub(/\(\d*\)/, " ").split("   ")
      theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      urls.each {|url| theater_hash[:urls] << url.attributes["href"].value}
      theater_hash[:urls].uniq!
      times.each {|time| theater_hash[:times] << time.text}
      theater_array << theater_hash
    end
    theater_array
  end
  
  def self.scrape_movie_page(url)
    movie = Nokogiri::HTML(open(url))
    puts 
    puts movie.css(".movie-rating-score +  p").text #release date
    puts movie.css(".movie-rating-score + p + p strong").text.tr("\n", "").strip.split.join(" ")
    puts
    puts movie.css("strong + p").text
    puts
  end

end
