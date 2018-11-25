require "selenium-webdriver"
require 'pry'
require 'csv'

Images = 'news-tidings__image'
Headers = 'news-tidings__subtitle'
Content = 'news-tidings__speech'

links = []
news_headers = []
news_content = []
news_images = []

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
binding.pry
driver = Selenium::WebDriver.for(:chrome, options: options)
binding.pry
driver.get('https://www.onliner.by/')

puts driver.title

driver.find_element(:link_text, 'ЛЮДИ').click

def find_elements_on_page(driver, elements_array, what_need_find)
	driver.find_elements(:class, what_need_find).each do |item|
		elements_array << item.text[0..199] if item.text.to_s.size != 0
	end
	elements_array.uniq!
end

def find_img_hrefs(driver, elements_array, what_need_find)
	driver.find_elements(:class, what_need_find).each do |item|
		elements_array << item.style('background-image').to_s[4..-3] if item.style('background-image').to_s.include?('550x298')
	end
	elements_array.uniq!
end

result1 = find_elements_on_page(driver, news_headers, Headers)
result2 = find_elements_on_page(driver, news_content, Content)
result3 = find_img_hrefs(driver, news_images, Images)
driver.find_element(:class, 'news-more__button').click
result1 = find_elements_on_page(driver, news_headers, Headers)
result2 = find_elements_on_page(driver, news_content, Content)
result3 = find_img_hrefs(driver, news_images, Images)
driver.find_element(:class, 'news-more__button').click
result1 = find_elements_on_page(driver, news_headers, Headers)
result2 = find_elements_on_page(driver, news_content, Content)
result3 = find_img_hrefs(driver, news_images, Images)

puts result1.size
puts result2.size
puts result3.size

all_info = []

(0..result1.size).each do |i|
	temp = []
	temp << result1[i]
	temp << result2[i]
	temp << result3[i]
	all_info << temp
end

if File.zero?("onliner_data.csv")
	CSV.open('onliner_data.csv', 'a+') do |csv|
		(0..result1.size).each do |index|
			csv << all_info[index]
		end
	end
end
