require 'sinatra'
require 'mysql'
require 'yaml'

configure do
	enable :logging
	set :bind, '0.0.0.0'
end

DB_CONFIG = YAML::load(File.open('config/database.yml'))

#http://rubylearning.com/blog/2007/05/14/ruby-mysql-tutorial/
#my = Mysql.new(hostname, username, password, databasename)
con = Mysql.new('localhost', DB_CONFIG['username'], DB_CONFIG['password'], 'interview')

get '/' do
  con.query("INSERT INTO wonks (title) VALUES('foo')");
  erb :content
end
