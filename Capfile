default_run_options[:pty] = true

set :user,              'hughevans'
set :domain,            'penguin.dreamhost.com'
set :application,       'hughevans.net'
set :repository,        "#{user}@#{domain}:code/#{application}.git"
set :deploy_to,         "/home/#{user}/#{application}" 
set :deploy_via,        :remote_cache
set :scm,               'git'
set :branch,            'master'
set :git_shallow_clone, 1
set :scm_verbose,       true
set :use_sudo,          false

server domain, :app, :web

before 'deploy:setup',       'vendor:create_dir'
before 'deploy:setup',       'vendor:install_gems'
after  'deploy:update_code', 'vendor:symlink'

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end

namespace :vendor do
  task :create_dir do
    run "mkdir -p #{shared_path}/vendor"
  end

  task :symlink do
    run "ln -nfs #{shared_path}/vendor #{release_path}/vendor"
  end

  task :install_gems do
    %w{sinatra rack}.each do |g|
      run "gem install #{g}"
      run "cd #{shared_path} && gem unpack #{g} && mv #{g}-* #{g}"
    end
  end
end