namespace :deploy do
    namespace :assets do
      task :precompile, :roles => :web, :except => { :no_release => true } do
        
        assets_changed = false
        if releases.length < 1
          assets_changed = true
        else
          from = source.next_revision(current_revision)
          assets_changed = capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        end
        
        if assets_changed
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
        
    end
  end
end
