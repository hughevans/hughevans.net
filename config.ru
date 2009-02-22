require 'rubygems'
require 'vendor/rack/lib/rack'
require 'vendor/sinatra/lib/sinatra'

disable :run
set :app_file, 'hughevans.rb'
set :views,    '/home/hughevans/deployments/hughevans.net/current/views'

require 'hughevans'
run Sinatra::Application