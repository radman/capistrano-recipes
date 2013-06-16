require "capistrano-recipes/version"
require "capistrano/bootstrap_deploy"

#Dir.glob(File.join(File.dirname(__FILE__), '/capistrano-recipes/*.rb')).sort.each { |f| load f }

require 'capistrano'

Capistrano::Configuration.instance(:must_exist).load do
  Dir.glob(File.join(File.dirname(__FILE__), '/capistrano-recipes/*.rb')).sort.each { |f| load f }

  #load "config/recipes/base"
  #load "config/recipes/rails"
  #load "config/recipes/nginx"
  #load "config/recipes/unicorn"
  #load "config/recipes/mysql"
  #load "config/recipes/cache"

  server "23.21.115.207", :app, :web, :db, :primary => true
  set :nginx_server_name, ".dreamcodelabs.com dreamcodelabs.raduvlad.com"
  set :application, "dreamcode"

  set :user, "deployer"
  set :deploy_to, "/home/#{user}/apps/#{application}"
  set :deploy_via, :remote_cache
  set :use_sudo, false

  set :scm, :git
  set :repository, "git@git.raduvlad.com:radu/#{application}.git"
  set :branch, "master"
  set :rails_env, "production"

  default_run_options[:pty] = true # for password prompts
  ssh_options[:forward_agent] = true # forward local ssh keys to server (make sure you've used ssh-add for each key you want to forward)

  after "deploy", "deploy:cleanup" # keep only the last 5 releases
end


