Capistrano::Configuration.instance(:must_exist).load do 
  namespace :radu do
    desc "Awesomeness"
    task :awesomeness do
      puts "yoyo wat up"
    end
  end
end
