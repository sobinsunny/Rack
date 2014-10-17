require "erb"
require 'rubygems'
require 'rack'
require 'rack/server'
require './app/controllers/base.rb'
require './app/models/post_model.rb'

class PostController < Basecontroller

  def index
     @posts = Post.all
  	 render "common/index"
   end
end