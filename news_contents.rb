class NewsContents
	attr_accessor :content
	def initialize(content)
		@content ||= []
	end
end