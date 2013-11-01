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

You'll need the mysql root password which is under 1password under "bootstrap - mysql"

You'll also need to have the project in version control at git.dreamcodelabs.com

Then run the following commands for your first deployment:

    bundle exec cap deploy setup
    bundle exec cap deploy:cold

You may also have to set up your database with seed data.
