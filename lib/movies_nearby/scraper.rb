class MoviesNearby::Scraper
  https://www.moviefone.com/showtimes/bronx-ny/10458/theaters/
  attr_accessor :base, :borough, :zip_code, :url

  def initialize(base, borough, zip_code)
    @base = base
    @borough = borough
    @zip_code = zip_code
    @url = base + borough + "-ny/" + zip_code + "/theaters/"
  end
  def scrape
    Nokogiri::HTML(open(url))
  end
end
