class MoviesNearby::Scraper
  #https://www.moviefone.com/showtimes/bronx-ny/10458/theaters/
  attr_accessor :url, :doc

  def initialize(url)
   @url = url
  end
  def scrape
    @doc = Nokogiri::HTML(open(url))
  end

end
