require 'capistrano'

Capistrano::Configuration.instance(:must_exist).load do
  def template(from, to)
    erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
    put ERB.new(erb).result(binding), to
  end

  def set_default(name, *args, &block)
    set(name, *args, &block) unless exists?(name)
  end

  def tail_log(name)
    stream "tail -f #{shared_path}/log/#{name}.log"
  end

  namespace :deploy do
    desc "Install everything onto the server"
    task :install do
      run "#{sudo} apt-get -y update"
      run "#{sudo} apt-get -y install python-software-properties"
    end

    desc "Remove current app from the server"
    task :remove_app do
      run "rm -rf #{deploy_to}"

      run "#{sudo} rm -f /etc/nginx/sites-enabled/#{application}"
      run "#{sudo} rm -f /etc/init.d/unicorn_#{application}"
      run "#{sudo} update-rc.d -f unicorn_#{application} remove"
    end
    before "deploy:remove_app", "unicorn:stop"
    after "deploy:remove_app", "nginx:restart"
    
  end
end