namespace :deploy do
    namespace :assets do
      task :precompile, :roles => :web, :except => { :no_release => true } do
        # NOTE: I sometimes run into problems with this on first releases, i.e. on cap deploy:cold with no symlink pointing to current release
        from = source.next_revision(current_revision)
        
        if releases.length <= 1 || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
    end
  end
end
