namespace :cache do
  desc "Create cache directory."
  task :setup, roles: :app do
    run "umask 02 && mkdir -p #{shared_path}/cache"
  end
  after "deploy:setup", "cache:setup"

  desc "Symlink the cache directory for the latest release"
  task :symlink, roles: :app do
    run <<-CMD
      cd #{release_path} &&
      ln -nfs #{shared_path}/cache #{release_path}/public/cache
    CMD
  end
  after "deploy:update_code", "cache:symlink"

  def mysql(command)
    run %Q{mysql --user=root --password=#{mysql_root_password} -e "#{command}"}
  end
end
