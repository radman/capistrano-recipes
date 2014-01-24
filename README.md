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

    require 'capistrano-recipes'
    
Update Capfile if you're using asset pipeline.

Upload repo to git.dreamcodelabs.com.

You'll need the mysql root password which is under 1password under "bootstrap - mysql"

Then run the following commands for your first deployment:

    bundle exec cap deploy:setup
    bundle exec cap deploy:cold
