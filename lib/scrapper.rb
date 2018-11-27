# frozen_string_literal: true

require 'selenium-webdriver'
require './csv_writer'
require './constants'
require 'pry'

# main class for onliner scrapping
class Scrapper
  attr_accessor :options, :titles, :contents, :images

  def initialize(driver)
    @driver = driver
    driver.get(ONLINER_URL)
    @images = []
    @titles = []
    @contents = []
  end

  def run_onliner_scrapper
    go_to_news
    more_news
    find_all_info
  end

  private

  def find_all_info
    find_images_hrefs
    find_news_content
    find_news_titles
  end

  def find_images_hrefs
    @images += scrap_imges
  end

  def find_news_content
    @contents += scrap_contents
  end

  def find_news_titles
    @titles += scrap_titles
  end

  def go_to_news
    @driver.find_element(:link_text, PEOPLE).click
  end

  def scrap_all(class_element)
    @driver.find_elements(:class, class_element).each_with_object([]) do |item, elements_array|
      elements_array << item.text[0..199] unless item.text.to_s.empty?
    end
  end

  def scrap_imges
    @driver.find_elements(:class, IMG).each_with_object([]) do |item, elements_array|
      elements_array << item.style(IMG_STYLE).to_s[4..-3]
    end
  end

  def scrap_uniq(class_element)
    scrap_all(class_element)
  end

  def scrap_titles
    scrap_uniq(TITLE)
  end

  def scrap_contents
    scrap_uniq(CONTENT)
  end

  def more_news
    @driver.find_element(:class, MORE_BUTTON).click
  end
end
