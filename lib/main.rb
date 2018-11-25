# frozen_string_literal: true

require 'csv'
require './scrapper'

scrapper = Scrapper.new
scrapper.run_onliner_scrapper
