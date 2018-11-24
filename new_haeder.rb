class NewsHeaders
	attr_accessor :headers
	def initialize(headers)
		@headers ||= []
	end
end