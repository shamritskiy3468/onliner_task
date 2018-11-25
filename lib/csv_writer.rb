require 'csv'

class CSVWriter
	attr_accessor :file
	def initialize(file)
		@file = file
		@data_to_write = []
	end

	def prepare_data_to_writing(a,b,c)
		(0..a.size).each do |i|
			temp = []
			temp << a[i]
			temp << b[i]
			temp << c[i]
			@data_to_write << temp
		end
	end	

	def write_data
		CSV.open(@file, 'a+') do |csv|
			(0..@data_to_write.size).each do |index|
				csv << @data_to_write[index]
			end
		end
	end
end
