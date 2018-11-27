# frozen_string_literal: true

# class to separate functonal in Scrapper and Writer
class CSVDataHandler
  attr_accessor :scrapper, :writer

  def initialize(scrapper, writer)
    @scrapper = scrapper
    @writer = writer
  end

  def start_scrapping
    @scrapper.run_onliner_scrapper
    @writer.prepare_data_to_writing(scrapper.titles, scrapper.contents, scrapper.images)
    @writer.write_data
  end
end
