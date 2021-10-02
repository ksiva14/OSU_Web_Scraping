# class for page object
class Page
  attr_reader :link, :number_of_pages

  def initialize
    @link = []
    @number_of_pages = 0
  end

  # get the link for each individual page
  def create_link
    @link << 'https://dps.osu.edu/news?tag%5B15%5D=15'
    (1..@number_of_pages).each do |i|
      @link << "https://dps.osu.edu/news?tag%5B15%5D=15&page=#{i}"
    end
  end

  # counts the number of pages
  def get_num_of_pages(page)
    # counts the number of page buttons at bottom of page
    @number_of_pages = page.search('li.pager__item span.element-invisible').length
    # do not count the previous, next, first, last button
    @number_of_pages -= 4
  end
end
