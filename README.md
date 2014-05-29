# Capistrano::Recipes

My deployment recipes.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-recipes', :github => "radman/capistrano-recipes", :require => false

## Usage

If installing w/o capistrano already present:

    capify .

Set up your deploy.rb to look something like this:

    require 'bundler/setup'
    require 'bundler/capistrano'

    set :nginx_server_name, "b2g.dreamcodelabs.com"
    set :application, "b2g"
    
    # Config File Setup
    # set :config_files, %w[mail]
    # set :config_file_templates_dir, File.expand_path("../deploy/templates/config", __FILE__)
    
    # Override Templates Directory (actually just prepends this dir to template load paths)
    # set :templates_dir, File.expand_path("../deploy/templates", __FILE__)

    require 'capistrano-recipes'
    
    # set :repository, "git@git.dreamcode.ca:radu/#{application}.git"
    
Update Capfile if you're using asset pipeline.

Upload repo to git.dreamcodelabs.com.

You'll need the mysql root password which is under 1password under "bootstrap - mysql"

Then run the following commands for your first deployment:

    bundle exec cap deploy:setup
    bundle exec cap deploy:cold
