require "selenium-webdriver"
require 'csv'
require './constants'
require 'pry'

class Scrapper
	attr_accessor :options, :driver

	def initialize
		#binding.pry
		@options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
		binding.pry
		@driver =  Selenium::WebDriver.for(:chrome, options: @options).get('https://www.onliner.by/')
		binding.pry
		# @driver.get('https://www.onliner.by/')
		@images, @titles, @contents = [], [], []
		#binding.pry
	end

	def connect
		binding.pry
		@driver.get('https://www.onliner.by/')
	end

	def run_onliner_scrapper
		connect
		go_to_news
		2.times do
			get_all_info
			get_more_news
		end
		get_all_info
		writer = CSVWriter.new('onliner_data.csv')
		writer.prepare_data_to_writing(titles, contents, images)
		writer.write_data
	end

	def get_all_info
		find_images_hrefs
		find_news_content
		find_news_titles	
	end

	def find_images_hrefs
		@images + scrap_imges
	end

	def find_news_content
		@images + scrap_contents
	end

	def find_news_titles
		@titles + scrap_titles
	end	

	def go_to_news
		binding.pry
		@driver.find_element(:link_text, PEOPLE).click
	end

private

	def scrap_imges
		elements_array = []
		@driver.find_elements(:class, IMG).each do |item|
			elements_array << item.style('background-image').to_s[4..-3] if item.style('background-image').to_s.include?('550x298')
		end
		elements_array.uniq!
	end

	def scrap_titles
		elements_array = []
		@driver.find_elements(:class, TITLE).each do |item|
			elements_array << item.text[0..199] if item.text.to_s.size != 0
		end
		elements_array.uniq!
	end

	def scrap_contents
		elements_array = []
		@driver.find_elements(:class, CONTENT).each do |item|
			elements_array << item.text[0..199] if item.text.to_s.size != 0
		end
		elements_array.uniq!
	end

	def get_more_news	
		@driver.find_element(:class, 'news-more__button').click
	end
end
