$LOAD_PATH << "."
require 'rack' 
require 'erb'

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
# [200, {"Content-Type"=>"text/html"},["#{@method}"]]

		if( @path=='/user'||@path=="/")
			@users=["alen","harry","been"]
			Rack::Response.new(render 'user/index')			           	 	

		#elsif  (!!@path.match('/user\/\d'))||@path=="/user/view"
		elsif  @path=="/user/view"
			controller_class,action=get_controller_and_action(@path)
			controller_file="./app/controllers/"+controller_class+"_control.rb"
			if load controller_file

				class_name=controller_class.capitalize+"Controller"
				ob=eval(class_name+".new()")
				Rack::Response.new(ob.send("index"))
				#[200, {"Content-Type"=>"text/html"},["#{class_name}"]]

			end					           	 	
		else
			[404, {"Content-Type"=>"text/html"},["Not found"]]
		end
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
#
end      

use Rack::CommonLogger
use Rack::ContentLength
run Blog
