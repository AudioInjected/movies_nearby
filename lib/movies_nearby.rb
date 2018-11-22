require 'bundler'
Bundler.require
require "movies_nearby/version"
require_relative "./movies_nearby/cli"


module MoviesNearby
  class Error < StandardError; end
  # Your code goes here...
end
