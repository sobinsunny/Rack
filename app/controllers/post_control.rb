require "erb"
require 'rubygems'
require 'rack'
require 'rack/server'
require './app/controllers/base.rb'
require './app/models/post_model.rb'
require './app/models/user_model.rb'


class PostController < Basecontroller

  def index
     @posts = Post.all
  	 render "post/index"
   end
   def new             
   	                render "post/new"
    end  

   def create     
               	 @use_id=@session[:user_id]
                  if (checker(@use_id))
                    render "user/index"
                  end               

                   	 post = Post.new(@params)
                	   post.user_id=@use_id;
                	   post.save
                	   if (post.save)
                	    	self.index
                	   else
                	    	return "Post Failed"
                     end	 
  end
    def profile
            @use_id=@session[:user_id]
            @users_prof=Post.where(:user_id=>@use_id)#find_all_by_user_id('3')
            render "post/profile"
    end

end