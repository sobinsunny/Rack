require "erb"

class Basecontroller

	  def initialize(id,params)
	   	@params=params
	   	@id=id
	   end   

		def render(template)
					path=File.expand_path("../../view/#{template}.html.erb",__FILE__)
					ERB.new(File.read(path)).result(binding)
		end 
	end