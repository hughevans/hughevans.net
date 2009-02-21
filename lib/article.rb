# Code originally from toolmantim:
# http://github.com/toolmantim/toolmantim/blob/972372615c534916a3a1c8ae0f01e72626ca83e0/lib/article.rb
class Article
  def self.path=(path)
    @path = path
  end
  
  def self.path(article_slug = nil)
    article_slug ? File.join(@path, "#{article_slug}.haml") : @path
  end

  def self.files
    Dir["#{File.expand_path(Article.path)}/*.haml"]
  end

  def self.all
    self.files.map {|f| new(f, File.read(f))}
  end

  def self.[](id)
    path = path(id.gsub('-', '_'))
    File.exist?(path) && new(path, File.read(path))
  end

  def self.template_variable(text, name)
    text[/\-\s*#\s*#{name}:\s*(.+)/, 1]
  end

  def self.parse_date(date_string)
    date_string && Time.local(*date_string.split('-').map {|s| s.to_i})
  end

  attr_reader :path, :template

  def initialize(file_path, file_contents)
    @path = file_path
    @template = file_contents
  end

  def slug
    File.basename(self.path, '.haml')
  end
  
  def id
    slug.gsub('_', '-')
  end

  def title
    template_variable('title')
  end

  def published
    @published ||= self.class.parse_date(template_variable('published'))
  end

  def updated
    @updated ||= self.class.parse_date(template_variable('updated'))
  end

  def last_modified
    updated || published
  end

  def template_variable(name)
    self.class.template_variable(self.template, name)
  end
  
  def <=>(other)
    [other.published.year, other.published.month, other.published.day] <=> [self.published.year, self.published.month, self.published.day]
  end
end