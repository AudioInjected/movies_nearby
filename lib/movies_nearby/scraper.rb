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
    movies_array = []
    @theaters.each do |movies_list|
      movies = movies_list.css(".movie-data-wrap")
      movies.each do |movie|
      movie_hash = {}
      movie_hash[:title] = movie.css(".movietitle").text
      movie_hash[:time] = movie.css(".showtimes-list").text
      movie_hash[:url] = movie.css(".movietitle a").attr("href").value
      binding.pry
      end
    
    end
   # @theaters.first.css(".movie-data-wrap")
   # @theaters.first.css(".movie-data-wrap").first.css(".movietitle").text  # title
   # @theaters.first.css(".movie-data-wrap").first.css(".showtimes-list").text  # time
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
