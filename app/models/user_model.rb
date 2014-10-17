require 'mysql'
require 'active_record'
require 'yaml'
dbconfig = YAML::load(File.open('./app/config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
class User < ActiveRecord::Base

 
  def view_all_post

  end
end