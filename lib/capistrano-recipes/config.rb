if exists?(:config_files)

  set_default :config_file_templates_dir, nil

  namespace :config do
    config_files.each do |config_file|
      namespace "#{config_file}" do

        desc "Generate #{config_file}.yml"
        task :setup, :roles => :app do
          run "mkdir -p #{shared_path}/config"
          template "#{config_file}.yml.erb", "#{shared_path}/config/#{config_file}.yml", config_file_templates_dir
        end
        after "deploy:setup", "config:#{config_file}:setup"

        desc "Symlink #{config_file}.yml into latest release"
        task :symlink, roles: :app do
          run "ln -nfs #{shared_path}/config/#{config_file}.yml #{release_path}/config/#{config_file}.yml"
        end
        after "deploy:finalize_update", "config:#{config_file}:symlink"

      end
    end
  end

end
