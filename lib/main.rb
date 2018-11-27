# frozen_string_literal: true

require 'csv'
require './csv_data_handler'
require './constants'
require './scrapper'

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
scrapper = Scrapper.new(Selenium::WebDriver.for(:chrome, options: options))
writer = CSVWriter.new(FILE_NAME)
CSVDataHandler.new(scrapper, writer).start_scrapping
