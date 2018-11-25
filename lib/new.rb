# frozen_string_literal: true

# class for storing data about one separate new from onliner.by
class New
  attr_accessor :title, :content, :img_link

  def initialize(title, content, img_link)
    @title = title
    @content = content
    @img_link = img_link
  end

  def prepare_data_to_storing; end
end
