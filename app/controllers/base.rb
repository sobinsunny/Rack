require 'rack' 
require 'erb'
require 'rubygems'
require 'rack/server'


class Basecontroller
		attr_accessor :session

	  def initialize(id,params,session)
	   	@params=params
	   	@id=id
	   	@session = session
	   end   

		def render(template)
					path=File.expand_path("../../view/#{template}.html.erb",__FILE__)
					ERB.new(File.read(path)).result(binding)
		end 
	end