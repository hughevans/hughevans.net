load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

require 'yaml'

deploy_config = YAML.load(File.read 'deploy.yml')

set :user,              deploy_config['user']
set :domain,            deploy_config['domain']
set :application,       'hughevans.net'
set :repository,        'git://github.com/artpop/hughevans.net.git'
set :deploy_to,         "/home/#{user}/deployments/#{domain}" 
set :deploy_via,        :remote_cache
set :scm,               'git'
set :branch,            'master'
set :git_shallow_clone, 1
set :scm_verbose,       true
set :use_sudo,          false

server domain, :app, :web

require 'erb'

config_rackup = ERB.new <<-EOF
require 'rubygems'
require 'vendor/rack/lib/rack'
require 'vendor/sinatra/lib/sinatra'

disable :run
set :app_file, 'hughevans.rb'
set :views,    '#{deploy_to}/current/views'

require 'hughevans'
run Sinatra::Application
EOF

after 'deploy:setup',       'rackup:create_config'
after 'deploy:update_code', 'rackup:symlink'

namespace :rackup do
  task :create_config do
    put config_rackup.result, "#{shared_path}/system/config.ru"
  end
  
  task :symlink do
    run "ln -nfs #{shared_path}/system/config.ru #{release_path}/config.ru"
  end
end

after 'deploy:setup',       'vendor_gems:install_and_unpack'
after 'deploy:update_code', 'vendor_gems:symlink'

namespace :vendor_gems do
  task :install_and_unpack do
    run 'gem install sinatra -v 0.9.0.4' # Also installs rack 0.9.1
    run "cd #{shared_path}/system && gem unpack rack -v 0.9.1 && mv rack-0.9.1 rack"
    run "cd #{shared_path}/system && gem unpack sinatra -v 0.9.0.4 && mv sinatra-0.9.0.4 sinatra"
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