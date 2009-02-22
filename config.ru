require 'rubygems'
require 'vendor/rack/lib/rack'
require 'sinatra'

disable :run
set :app_file, 'hughevans.rb'
set :views,    '/home/hughevans/deployments/hughevans.net/current/views'

require 'hughevans'
run Sinatra::Application