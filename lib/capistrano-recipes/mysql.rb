require 'capistrano'

Capistrano::Configuration.instance(:must_exist).load do
  set_default(:mysql_host, "localhost")
  set_default(:mysql_user) { application.gsub(/-/,'_') }
  set_default(:mysql_password) { Capistrano::CLI.password_prompt "MySql Password: " }
  set_default(:mysql_root_password) { Capistrano::CLI.password_prompt "MySql Root Password: " }
  set_default(:mysql_database) { "#{application.gsub(/-/,'_')}_production" }

  namespace :mysql do
    desc "Create a database for this application."
    task :create_database, roles: :db, only: {primary: true} do
      mysql "create database #{mysql_database} character set utf8;"
      mysql "create user '#{mysql_user}'@'#{mysql_host}' identified by '#{mysql_password}';"
      mysql "grant all privileges on #{mysql_database}.* to '#{mysql_user}'@'#{mysql_host}';"
    end
    after "deploy:setup", "mysql:create_database"

    desc "Generate the database.yml configuration file."
    task :setup, roles: :app do
      run "mkdir -p #{shared_path}/config"
      template "mysql.yml.erb", "#{shared_path}/config/database.yml"
    end
    after "deploy:setup", "mysql:setup"

    desc "Symlink the database.yml file into latest release"
    task :symlink, roles: :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      #run "cd #{release_path} && bundle install --without development test"
    end
    #after "deploy:update_code", "mysql:symlink"
    before "bundle:install", "mysql:symlink"

    def mysql(command)
      run %Q{mysql --user=root --password=#{mysql_root_password} -e "#{command}"}
    end
  end
end
