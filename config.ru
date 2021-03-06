$LOAD_PATH << "."
require 'rack' 
require 'erb'
require 'rubygems'
use Rack::Session::Cookie , :secret => 'change_me'
require 'rack/server'
use Rack::Static,
:urls => ["/images", "/js", "/css"],
:root => "/public"


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
		params=@request.params	
		@request.session.update(@request.session);

	  	    controller_class,action,id=get_controller_and_action(@path)

        case @method

		    when 'GET'
		    	if @request.session.nil?
		    		  calling_fuc("user","index",id,params)
		    		else
		    		    calling_fuc(controller_class,action,id,params)	   		
		    		end	   		
		    when 'POST'
		    	    if @request.session.nil?
		    		  calling_fuc("user","index",id,params)
		    		else
		    		    calling_fuc(controller_class,action,id,params)	   		
		    	    end	  

		    when 'DELETE'
		    	    if @request.session.nil?
		    		  calling_fuc("user","index",id,params)
		    		else
		    		    calling_fuc(controller_class,action,id,params)	   		
		    	    end	   	
		end
  end


# #Helping function  for request processing


				def calling_fuc(contr_name,action,id,params)

		                controller_file="./app/controllers/"+contr_name+"_control.rb"

						if load controller_file

								class_name=contr_name.capitalize+"Controller"
								ob=eval(class_name+".new(id,params,@request.session)")
								Rack::Response.new(ob.send(action))
						end					           	 	


				end

			def get_controller_and_action(path)
					 
					case path
							when /^\/$/
								 return["user","logindir",nil]
							when /^\/(\w+)(\/)?$/
								
								controller="#{$1}"	

									return [controller,nil,nil]

							when /^\/(\w+)(\/)?([a-zA-Z_]+)(\/)?$/
									
									controller="#{$1}"
									action="#{$3}"
								   return [controller,action,nil]			


							when /^\/(\w+)(\/)?(\d+)(\/)?(\w*)?(\/)?$/

										controller="#{$1}"
										action="#{$5}"
										id="#{$3}"
										return [controller,action,id]
					end
		    end



#Helping function  for TEMPLATE RENDERING

		def render(template)

			path=File.expand_path("../app/view/#{template}.html.erb",__FILE__)
			ERB.new(File.read(path)).result(binding)

		end 

end      

use Rack::CommonLogger
use Rack::ContentLength
run Blog

