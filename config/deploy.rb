# config valid for current version and patch releases of Capistrano
# require 'capistrano-unicorn'
lock "~> 3.14.1"

set :application, "training"
set :repo_url, "git@github.com:sonld-1516/trainning.git"
set :deploy_to, "/usr/local/rails_app/training"

# set :pty, true
append :linked_files, "config/database.yml", "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle", ".bundle", "public_upload"
set :keep_releases, 5
set :pid_file, "#{shared_path}/tmp/pids/unicorn.pid"

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke "unicorn:restart"
    end
  end
end

after "deploy:publishing", "deploy:restart"

# namespace :deploy do
#   desc "Restart application"
#   task :restart do
#     invoke "unicorn:restart"
#   end
# end
# after "deploy:publishing", "deploy:restart"

# namespace :deploy do
#   ["start", "stop", "restart"].each do |command|
#     desc "#{command} unicorn server"
#     task command, roles: :app, except: {no_release: true} do
#       run "/etc/init.d/unicorn_deploy #{command}"
#     end
#   end
# end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
