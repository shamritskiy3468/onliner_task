# frozen_string_literal: true

require 'csv'
require './scrapper'

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
scrapper = Scrapper.new(Selenium::WebDriver.for(:chrome, options: options))
scrapper.run_onliner_scrapper
