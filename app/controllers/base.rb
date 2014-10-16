require "erb"
class Basecontroller
	    def initialize(params)
	    	@param=params
		end   

		def render(template)
					path=File.expand_path("../app/view/#{template}.html.erb",__FILE__)
					ERB.new(File.read(path)).result(binding)
		end 
	end

