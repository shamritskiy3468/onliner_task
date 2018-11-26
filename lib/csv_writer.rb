# frozen_string_literal: true

require 'csv'

# class for writing data from onliner in csv
class CSVWriter
  attr_accessor :file

  def initialize(file)
    @file = file
    @data = []
  end

  def prepare_data_to_writing(*arrays)
    (0...arrays.first.size).each do |i|
      @data << arrays.each_with_object([]) { |data, temp| temp << data[i] }
    end
  end

  def write_data
    CSV.open(@file, 'a+') do |csv|
      (0..@data.size - 1).each do |index|
        csv << @data[index]
      end
    end
  end
end
