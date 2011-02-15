require 'bundler/capistrano'

set :application, "revolting_age" # this will be used to create the folder structure (see line)
set :deploy_to, "/home/shadyfront/webapps/#{application}"

set :rails_env, "development"

set :user, "shadyfront"
set :use_sudo, false

ssh_options[:paranoid] = false
ssh_options[:keys] = %w("~/.ssh/")
set :domain, "174.133.20.24" #"IP or domain name of production server"

role :app, domain
role :web, domain
role :db, domain, :primary => true

set :scm, :git
set :scm_username, 'gotoAndBliss'
set :repository,  "git@github.com:gotoAndBliss/Age-of-Revolt.git"
set :branch, "master"

set :deploy_via, :remote_cache

set :scm_command, "git"

namespace :deploy do

  desc "Sync the config directory"
  task :sync_config do

    system "rsync -vr --exclude='*~' config #{user}@#{domain}:#{release_path}/"

    system "rsync -vr --exclude='*~' tmp #{user}@#{domain}:#{shared_path}/"

    system "rsync -vr --exclude='*~' db #{user}@#{domain}:#{release_path}/"

  end

  desc "Tell Nginx to restart the app."
  task :restart do
    #run "/home/shadyfront/webapps/age_of_revolt/bin/restart"
  end
  desc "Bundle Install That Bitch"
  task :bundle_install do
    #run "#{release_path}/bundle install"
  end

  deploy.task :start do
     # nothing
   end
end

after 'deploy:update_code', 'deploy:sync_config', 'deploy:restart'
