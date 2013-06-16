require 'capistrano'

module CapistranoRecipes
  class Test
    TASKS = [
      'radu:awesomeness'
    ]

    def self.load_into(capistrano_config)
      namespace :radu do
        desc "Awesomeness"
        task :awesomeness do
          puts "yoyo wat up"
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  CapistranoUnicorn::Test.load_into(Capistrano::Configuration.instance)
end
