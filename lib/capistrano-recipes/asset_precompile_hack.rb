namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      if releases.length <= 1
        logger.info "Not skipping asset precompilation because this is the first release."
        do_precompile and return
      else
        from = source.next_revision(current_revision)
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          do_precompile and return
        end
      end

      logger.info "Skipping asset pre-compilation because there were no asset changes"
    end

    def do_precompile
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
    end
  end
end
