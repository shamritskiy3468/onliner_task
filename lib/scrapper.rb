# frozen_string_literal: true

require 'selenium-webdriver'
require 'csv'
require './constants'
require 'pry'

# main class for onliner scrapping
class Scrapper
  attr_accessor :options, :driver

  def initialize
    @options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:chrome, options: @options).get('https://www.onliner.by/')
    @images = []
    @titles = []
    @contents = []
  end

  def connect
    @driver.get('https://www.onliner.by/')
  end

  def run_onliner_scrapper
    connect
    go_to_news
    2.times do
      all_info
      more_news
    end
    all_info
    writer = CSVWriter.new('onliner_data.csv')
    writer.prepare_data_to_writing(titles, contents, images)
    writer.write_data
  end

  def all_info
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
    @driver.find_element(:link_text, PEOPLE).click
  end

  private

  def scrap_imges
    elements_array = []
    @driver.find_elements(:class, IMG).each do |item|
      if item.style('background-image').to_s.include?('550x298')
        elements_array << item.style('background-image').to_s[4..-3]
      end
    end
    elements_array.uniq!
  end

  def scrap_titles
    elements_array = []
    @driver.find_elements(:class, TITLE).each do |item|
      elements_array << item.text[0..199] unless item.text.to_s.empty?
    end
    elements_array.uniq!
  end

  def scrap_contents
    elements_array = []
    @driver.find_elements(:class, CONTENT).each do |item|
      elements_array << item.text[0..199] unless item.text.to_s.empty?
    end
    elements_array.uniq!
  end

  def more_news
    @driver.find_element(:class, 'news-more__button').click
  end
end
