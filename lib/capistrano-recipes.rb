require "capistrano-recipes/version"
require "capistrano"

Dir.glob(File.join(File.dirname(__FILE__), '/capistrano-recipes/*.rb')).sort.each { |f| load f }

