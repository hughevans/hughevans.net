require 'rubygems'
require 'vendor/sinatra/lib/sinatra.rb'

Sinatra::Application.set(
  :run => false,
  :environment => 'production',
  :views => '/home/hughevans/hughevans.net/current/views'
)

require 'hughevans.rb'
run Sinatra::Application