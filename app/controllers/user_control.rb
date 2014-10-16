require "erb"
require 'rubygems'
require 'rack'
require 'rack/server'
require './app/controllers/base.rb'
require './app/models/user_model.rb'

class UserController < Basecontroller

  def index
     @users = User.all
  	 render "user/index"
  end
end