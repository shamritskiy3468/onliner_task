# frozen_string_literal: true

require 'selenium-webdriver'
require 'pry'
require 'csv'

IMAGES = 'news-tidings__image'
HEADERS = 'news-tidings__subtitle'
CONTENT = 'news-tidings__speech'

news_headers = []
news_content = []
news_images = []

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
driver = Selenium::WebDriver.for(:chrome, options: options)
driver.get('https://www.onliner.by/')

puts driver.title

driver.find_element(:link_text, 'ЛЮДИ').click

def find_elements_on_page(driver, elements_array, what_need_find)
  driver.find_elements(:class, what_need_find).each do |item|
    elements_array << item.text[0..199] unless item.text.to_s.empty?
  end
  elements_array.uniq!
end

def find_img_hrefs(driver, elements_array, what_need_find)
  driver.find_elements(:class, what_need_find).each do |item|
    if item.style('background-image').to_s.include?('550x298')
      elements_array << item.style('background-image').to_s[4..-3]
    end
  end
  elements_array.uniq!
end

result1 = find_elements_on_page(driver, news_headers, HEADERS)
result2 = find_elements_on_page(driver, news_content, CONTENT)
result3 = find_img_hrefs(driver, news_images, IMAGES)
driver.find_element(:class, 'news-more__button').click
result1 = find_elements_on_page(driver, news_headers, HEADERS)
result2 = find_elements_on_page(driver, news_content, CONTENT)
result3 = find_img_hrefs(driver, news_images, IMAGES)
driver.find_element(:class, 'news-more__button').click
result1 = find_elements_on_page(driver, news_headers, HEADERS)
result2 = find_elements_on_page(driver, news_content, CONTENT)
result3 = find_img_hrefs(driver, news_images, IMAGES)

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

if File.zero?('onliner_data.csv')
  CSV.open('onliner_data.csv', 'a+') do |csv|
    (0..result1.size).each do |index|
      csv << all_info[index]
    end
  end
end
