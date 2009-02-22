load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

set :user,              'hughevans'
set :domain,            'penguin.dreamhost.com'
set :application,       'hughevans.net'
set :repository,        "#{user}@#{domain}:code/#{application}.git"
set :deploy_to,         "/home/#{user}/deployments/#{application}" 
set :deploy_via,        :remote_cache
set :scm,               'git'
set :branch,            'master'
set :git_shallow_clone, 1
set :scm_verbose,       true
set :use_sudo,          false

server domain, :app, :web

after 'deploy:setup',       'rack:install'
after 'deploy:update_code', 'rack:symlink'

namespace :rack do
  task :install do
    run 'gem install sinatra -v 0.9.0.4' # Also installs rack 0.9.1
    run "cd #{shared_path}/system && gem unpack rack && mv rack-* rack"
    run "cd #{shared_path}/system && gem unpack sinatra && mv sinatra-* sinatra"
  end

  task :symlink do
    run "mkdir -p #{release_path}/vendor/"
    run "ln -nfs #{shared_path}/system/rack #{release_path}/vendor/rack"
    run "ln -nfs #{shared_path}/system/sinatra #{release_path}/vendor/sinatra"
  end
end

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end