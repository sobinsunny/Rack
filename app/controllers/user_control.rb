require "erb"
require './app/models/user_model.rb'
class Basecontroller

	 #    def initialize(params)
	 #    	@params=params
		# end   

		def render(template)
					path=File.expand_path("../../view/#{template}.html.erb",__FILE__)
					ERB.new(File.read(path)).result(binding)
		end 
	end
class UserController < Basecontroller

  def index
     @users = User.all
  	 render "user/index"
  end
end