require "capistrano-recipes/version"

#Dir.glob(File.join(File.dirname(__FILE__), '/capistrano-recipes/*.rb')).sort.each { |f| load f }

require 'capistrano'

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.load do
    #set :config_files, %w[radu fog aws] unless exists?(:config_files) # used by config.rb
    set :templates_dir, File.expand_path("../capistrano-recipes/templates", __FILE__) unless exists?(:templates_dir) # used by base.rb

    Dir.glob(File.join(File.dirname(__FILE__), '/capistrano-recipes/*.rb')).sort.each { |f| load f }

    server "23.21.115.207", :app, :web, :db, :primary => true
    #set :nginx_server_name, ".dreamcodelabs.com dreamcodelabs.raduvlad.com"
    #set :application, "dreamcode"

    set :user, "deployer"
    set :deploy_to, "/home/#{user}/apps/#{application}"
    set :deploy_via, :remote_cache
    set :use_sudo, false

    set :scm, :git
    set :repository, "git@git.dreamcodelabs.com:radu/#{application}.git"
    set :branch, "master"
    set :rails_env, "production"

    default_run_options[:pty] = true # for password prompts
    ssh_options[:forward_agent] = true # forward local ssh keys to server (make sure you've used ssh-add for each key you want to forward)

    set :keep_releases, 2
    after "deploy", "deploy:cleanup" # keep only the last 5 releases
  end
end

