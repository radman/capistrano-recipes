Capistrano::Configuration.instance.load do 
  namespace :radu do
    desc "Awesomeness"
    task :awesomeness do
      puts "yoyo wat up"
    end
  end
end
