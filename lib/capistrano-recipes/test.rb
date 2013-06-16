require 'capistrano'

Capistrano::Configuration.instance(:must_exist).load do
  namespace :radu do
    desc "Awesomeness"
    task :more_awesomeness do
      puts "yoyo wat up"
    end
  end
end
#module CapistranoRecipes
#  class Test
#    TASKS = [
#      'radu:awesomeness'
#    ]
#
#    def self.load_into(capistrano_config)
#      capistrano_config.load do
#        namespace :radu do
#          desc "Awesomeness"
#          task :awesomeness do
#            puts "yoyo wat up"
#          end
#        end
#      end
#    end
#  end
#end
#
#if Capistrano::Configuration.instance
#  CapistranoRecipes::Test.load_into(Capistrano::Configuration.instance)
#end
