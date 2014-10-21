require 'mysql'
require 'active_record'
require 'yaml'
dbconfig = YAML::load(File.open('./app/config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
class Post < ActiveRecord::Base
		belongs_to :user
		validates :title, presence: true,
                    length: { minimum: 5 }
   
end