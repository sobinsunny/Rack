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
			  	 @u=User.find_by_username(uname)
			  	 @id_user=@u.id 	 
			  	 if @u.password_hash==paswd		 	
			  	 	@session[:user_id]=@u.id
			  	 	@posts=Post.all
			  	 	render "post/index"	  	 	

			  	 else
			  	 	return "Login not Suceesful"
			     end 	
		    end
		    def logindir
 				render "user/login"
			end

			def logout
				session.delete(:user_id)
				render "user/login"
		    end
		    def reg     
                   	 us= User.new(@params)
		                	   if (us.save)
		                	    	render "user/login"
		                	   else
		                	    	return "Registration faild"
                     end	 

		    end
		    def regi
				render "user/registration"
		    end
		    def destroy
			@user_id=@session[:user_id]
            @post_user_id=Post.find(@id).user_id
            render "post/index"
			end
  			
 	

end