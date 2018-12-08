class MoviesNearby::Scraper
# "https://www.moviefone.com/showtimes/staten-island-ny/10302/theaters/"

  def self.create_doc(url)
    @doc = Nokogiri::HTML(open(url))
    @theaters = @doc.css("div.theater")
  end

  def self.scrape_theater
    theater_array = []
    @theaters.each do |theater|
      theater_hash = {}
      theater_hash[:name] = theater.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      theater_array << theater_hash
    end
    theater_array
  end
  
  def self.scrape_movie
    movie_array = []
    @theaters.each do |movie|
      times = movie.css("div.movie-listing").css(".showtimes-list")
      urls = movie.css(".moviePoster a")
      movie_hash = {}
     # movie_hash[:theater_name] = movie.css("div.title").text.tr("\t", "").tr("\n", "").split(".").last
      movie_hash[:times] = []
      movie_hash[:urls] = []
      movie_hash[:movies] = movie.css("div.movie-listing").css(".movietitle").text.gsub(/\(\d*\)/, " ").split("   ")
      urls.each {|url| movie_hash[:urls] << url.attributes["href"].value}
      movie_hash[:urls].uniq
      times.each {|time| movie_hash[:times] << time.text}
      movie_array << movie_hash
    end
    movie_array
  end
  
  def self.scrape_movie_info(url)
    movie = Nokogiri::HTML(open(url))
    movie_info = {}
    movie_info[:title] = movie.css(".hero-title h1").text #Title of Movie
    movie_info[:release_date] = movie.css(".movie-rating-score +  p").text #Release Date 
    movie_info[:rating] =  movie.css(".movie-rating-score + p + p strong").text.tr("\n", "").strip.split.join(" ") #Rating and length of Movie
    movie_info[:description] =  movie.css("strong + p").text #Movie Description
    movie_info
  end

end
