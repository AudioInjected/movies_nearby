require 'bundler'
Bundler.require
require 'pry'
require 'require_all'
require 'nokogiri'
require 'open-uri'
require "movies_nearby/version"
require_relative "./movies_nearby/cli"
require_relative "./movies_nearby/scraper"
require_relative "./movies_nearby/theater"


module MoviesNearby
  class Error < StandardError; end
  # Your code goes here...
end
