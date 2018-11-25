# frozen_string_literal: true

require 'csv'

# class for writing data from onliner in csv
class CSVWriter
  attr_accessor :file
  def initialize(file)
    @file = file
    @data_to_write = []
  end

  def prepare_data_to_writing(first_arr, second_arr, third_arr)
    (0..first_arr.size).each do |i|
      temp = []
      temp << first_arr[i]
      temp << second_arr[i]
      temp << third_arr[i]
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
