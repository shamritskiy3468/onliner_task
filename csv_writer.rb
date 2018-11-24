class CSVWriter
	attr_accessor :file
	def initialize(file)
		@file = file
	end

	def write_data(data_to_write)
		CSV.open(@file, 'a+') do |csv|
			(0..data_to_write.size).each do |index|
				csv << data_to_write[index]
			end
		end
	end
end
