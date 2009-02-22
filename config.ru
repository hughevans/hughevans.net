require 'rubygems'
require 'vendor/rack/rack'
require 'vendor/sinatra/lib/sinatra.rb'

disable :run
set :app_file, 'hughevans.rb'
set :views, File.dirname(__FILE__) + '/views'

require 'hughevans'
run Sinatra::Application