# frozen_string_literal: true

require 'csv'

# class for writing data from onliner in csv
class CSVWriter
  attr_accessor :file

  def initialize(file)
    @file = file
    @data_to_write = []
  end

  def prepare_data_to_writing(*arrays)
    (0..arrays.first.size).each do |i, result|
      @data_to_write = arrays.each_with_object([]) { |data| temp << data[i] }
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
