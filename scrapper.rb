require "selenium-webdriver"
require 'csv'
require 'constants'

class Scrapper
	attr_accessor :options, :driver

	def initialize
		@options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
		@driver = Selenium::WebDriver.for(:chrome, options: @options).get('https://www.onliner.by/')
		@images, @titles, @contens = [], [], []
	end

	def run_onliner_scrapper
		go_to_news
		2.times { get_all_info }
	end

	def get_all_info
		find_images_hrefs
		find_news_content
		find_news_titles

		writer = CSVWriter.new('onliner_data.csv')
		writer.write_data		
	end

	def find_images_hrefs
		@images = scrap_imges
	end

	def find_news_content
		@images = scrap_contents
	end

	def find_news_titles
		@titles = scrap_titles
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

	def go_to_news
		@driver.find_element(:link_text, PEOPLE).click
	end
end
