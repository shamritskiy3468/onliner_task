class New
	attr_accessor :title, :content, :img_link
	def initialize(title, content, img_link)
		@title = title
		@content = content
		@img_link = img_link
	end

	def prepare_data_to_storing
		
	end
end