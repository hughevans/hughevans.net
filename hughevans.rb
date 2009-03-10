require 'rubygems'
require 'sinatra'
require 'haml'
require 'time'
require 'lib/article'

Article.path = File.join(Sinatra::Application.root, 'articles')

helpers do
  def article_body(article)
    haml(article.template, :layout => false)
  end

  def article_path(article)
    "/#{article.published.strftime("%Y/%m/%d")}/#{article.id}"
  end
  
  def absoluteify_links(html)
    html.
      gsub(/href=(["'])(\/.*?)(["'])/, 'href=\1http://hughevans.net\2\3').
      gsub(/src=(["'])(\/.*?)(["'])/, 'src=\1http://hughevans.net\2\3')
  end
end

get '/' do
  @articles = Article.all.sort[0..7]
  haml :home
end

get '/:year/:month/:day/:id' do
  @article = Article[params[:id]] || raise(Sinatra::NotFound)
  @single_view = true
  haml :article
end

get '/articles.atom' do
  @articles = Article.all.sort
  content_type 'application/atom+xml'
  haml :feed, :layout => false
end

get '/:style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:style]}"
end

module Haml::Filters::Preserve
  def render(text)
    Haml::Helpers.preserve(Haml::Helpers.html_escape(text))
  end
end