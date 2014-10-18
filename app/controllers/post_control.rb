require "erb"
require 'rubygems'
require 'rack'
require 'rack/server'
require './app/controllers/base.rb'
require './app/models/post_model.rb'

class PostController < Basecontroller

  def index
     @posts = Post.all
  	 render "post/index"
   end
   def new
   	  render "post/new"
   	 end 
   def create     
   	 id=@id;
   	 post = Post.new(@params)
	 post.user_id=0;
	 post.save
	 return "success"
   end

end