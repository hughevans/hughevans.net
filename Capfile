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

before 'deploy:setup',       'rack:create_dir'
before 'deploy:setup',       'rack:install'
after  'deploy:update_code', 'rack:symlink'

namespace :rack do
  task :create_dir do
    run "mkdir -p #{shared_path}/rack/"
  end

  task :install do
    run 'gem install sinatra -v 0.9.0.4' # Also installs rack 0.9.1
    run "cd #{shared_path} && gem unpack rack && mv rack-* rack"
  end

  task :symlink do
    run "mkdir -p #{release_path}/vendor/"
    run "ln -nfs #{shared_path}/rack #{release_path}/vendor/rack"
  end
end

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end