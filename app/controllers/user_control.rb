require "erb"
require 'rubygems'
require 'rack'
require 'rack/server'
require './app/controllers/base.rb'
require './app/models/post_model.rb'
require './app/models/user_model.rb'
require './app/controllers/post_control.rb'
class UserController < Basecontroller

  def index
	     @users=User.all
	  	 render "user/index"
  end
		    def login
			  	 uname=@params["username"]
			  	 paswd=@params["password_hash"]
			  	 
			  	 @u=User.find_by(username: uname)
			  	 if @u.password_hash==paswd			  	 	
			  	 	@id_user=@u.id
			  	 	@session[:user_id]=@u.id
			  	 	@posts=Post.all
			  	 	render "post/index"	  	 	

			  	 else
			  	 	return "Login not Suceesful"
			     end 	
		    end
		    def profile
		    end
		    def logindir
 				render "user/login"
			end

			def logout
				session.delete(:user_id)
				render "user/login"
		    end
  			def checker(session)
			
				if session.nil?
					
				    render "user/index"

				end
 			end

end