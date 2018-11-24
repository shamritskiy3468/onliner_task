require "selenium-webdriver"
require 'csv'
require 'constants'

class Scrapper
	attr_accessor :options, :driver

	def initialize
		@options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
		@driver = Selenium::WebDriver.for(:chrome, options: @options).get('https://www.onliner.by/')
	end

	def run_onliner_scrapper
		go_to_news
	end

	def find_images_hrefs

	end

	def find_news_content

	end

	def find_news_titles

	end	

private

	def get_more_news
		@driver.find_element(:class, 'news-more__button').click
	end

	def go_to_news
		@driver.find_element(:link_text, PEOPLE).click
	end
end
