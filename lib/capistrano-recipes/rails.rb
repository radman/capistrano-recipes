namespace :rails do
  desc "Run a task on a remote server with parameter: task=followers:import"
  task :invoke, :roles => :app do
    run("cd #{deploy_to}/current && #{rake} RAILS_ENV=#{rails_env} #{ENV['task']}")  
  end

  desc "Remote console" 
  task :console, :roles => :app do
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( ./script/rails console production )
  end

  desc "Remote dbconsole" 
  task :dbconsole, :roles => :app do
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( ./script/rails dbconsole production )
  end

  desc "Tail production log"
  task :log, :roles => :app do
    tail_log("production")
  end

  def run_with_tty(server, cmd)
    # looks like total pizdets
    command = []
    command += %W( ssh -t #{gateway} -l #{self[:gateway_user] || self[:user]} ) if     self[:gateway]
    command += %W( ssh -t )
    command += %W( -p #{server.port}) if server.port
    command += %W( -l #{user} #{server.host} )
    command += %W( cd #{current_path} )
    # have to escape this once if running via double ssh
    command += [self[:gateway] ? '\&\&' : '&&']
    command += Array(cmd)
    system *command
  end
end
