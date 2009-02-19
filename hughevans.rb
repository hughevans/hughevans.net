require 'rubygems'
require 'yaml'
require 'sinatra'
require 'haml'

ARTICLES = YAML::load(File.read(File.join(Sinatra.application.options.root, 'articles.yml')))

helpers do
  def article(article)
    haml(:"articles/_#{article['slug']}", :layout => false)
  end
end

get '/' do
  haml :home
end

get '/:year/:month/:day/:slug' do
  @article = ARTICLES[params[:slug]] || raise(Sinatra::NotFound)
  @single_view = true
  haml :article
end

get '/:style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:style]}"
end

# I'll have my preserved text served escaped not stired..
module Haml::Filters::Preserve
  def render(text)
    Haml::Helpers.preserve(Haml::Helpers.html_escape(text))
  end
end