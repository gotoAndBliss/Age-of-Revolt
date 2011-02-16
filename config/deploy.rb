# Warning to my picky self: order of requires matters because they define new tasks and
# affect order of task operation.

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, "1.8.7@revolting_gems"
set :rvm_type, :user
set :user, "shadyfront"
set :use_sudo, false

set :stages, %w(testing staging production)
set :default_stage, 'testing'
require 'capistrano/ext/multistage'

default_run_options[:pty]   = true # must be set for the password prompt from git to work
ssh_options[:forward_agent] = true # use local keys instead of the ones on the server

set :application, "revolting_age"

ssh_options[:paranoid] = false
ssh_options[:keys] = %w("~/.ssh/")
set :domain, "174.133.20.24"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :scm, :git
set :scm_username, 'gotoAndBliss'
set :repository,  "git@github.com:gotoAndBliss/Age-of-Revolt.git"
set :branch, "master"

set :deploy_via, :remote_cache

set :scm_command, "~/bin/git"

after "deploy:update_code", "deploy:update_shared_symlinks"
require "bundler/capistrano"
after "bundle:install", "deploy:migrate"

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp/restart.txt")}"
  end

  task :update_shared_symlinks do
    %w(config/database.yml).each do |path|
      run "rm -rf #{File.join(release_path, path)}"
      run "ln -s #{File.join(deploy_to, "shared", path)} #{File.join(release_path, path)}"
    end
  end
end

# config/deploy/testing.rb
  set :deploy_to, "/home/shadyfront/webapps/revolting_age/testing/age_of_revolt/"
  set :rails_env, :development

# config/deploy/staging.rb
  set :deploy_to, "/home/shadyfront/webapps/revolting_age/development/age_of_revolt/"
  set :rails_env, :production

# config/deploy/production.rb
  set :deploy_to, "/home/shadyfront/webapps/revolting_age/production/age_of_revolt/"
  set :rails_env, :production