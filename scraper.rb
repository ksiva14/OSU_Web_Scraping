class Scraper
  attr_reader :number_of_pages, :page_array

  def initialize
    @number_of_pages = 0
    @page_array = []
  end

  # counts the number of pages
  def get_num_of_pages(page)
    # counts the number of page buttons at bottom of page
    @number_of_pages = page.search('li.pager__item span.element-invisible').length
    # do not count the previous, next, first, last button
    @number_of_pages -= 4
  end

  # get the link for each individual page
  def create_link(first_page_link)
    (1..@number_of_pages).each do |i|
      # mechanize each page
      @page_array << Page.new("#{first_page_link}&page=#{i}")
    end
  end
end
