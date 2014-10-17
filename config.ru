$LOAD_PATH << "."
require 'rack' 
require 'erb'
require 'rubygems'

require 'rack/server'

use Rack::Static
use Rack::Static,
:urls => ["/images", "/js", "/css"],
:root => "public"


class Blog
	def self.call(env)
		new(env).response
	end

	def initialize(env)
		@request=Rack::Request.new(env)
	end
	def response

		@path=@request.path
		@method=@request.request_method
		@params=@request.params	

	   if @method=='GET'

				if( @path=='/user'||@path=="/")
					@users=["alen","harry","been"]
					Rack::Response.new(render 'user/index')	
				end		           	 	

						controller_class,action=get_controller_and_action(@path)
						controller_file="./app/controllers/"+controller_class+"_control.rb"

				if load controller_file
					
						class_name=controller_class.capitalize+"Controller"
						ob=eval(class_name+".new(@params)")
						Rack::Response.new(ob.send(action))
				end					           	 	
		else
				[404, {"Content-Type"=>"text/html"},["Not found"]]
		end
	end




#Helping function  for request processing

				def render(template)

					path=File.expand_path("../app/view/#{template}.html.erb",__FILE__)
					ERB.new(File.read(path)).result(binding)

				end 

				def get_controller_and_action(path)

					_,controller_name,action=path.split("/")					      
					return  controller_name,action
				end      	
				
end      

use Rack::CommonLogger
use Rack::ContentLength
run Blog
