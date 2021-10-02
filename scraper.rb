require_relative 'notice'

class Scraper
  attr_reader :number_of_pages, :page_array, :all_notices, :years, :crime_per_year

  def initialize
    @number_of_pages = 0
    # keeps track of all page object
    @page_array = []
    # keeps track of all notice object
    @all_notices = []
    # range of years for the data
    @years = []
    # hash of year and crime count
    @crime_per_year = {}
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
      @page_array << Page.new("#{first_page_link}&page=#{i}", @all_notices)
    end
  end

  # calls other methods to retrieve all data
  def collect_data
    get_all_years
    get_crimes_per_year
  end

  # gets all the years that has crime recorded
  def get_all_years
    all_notices.each do |notice|
      # does not push the same year or nil
      @years << notice.year if !notice.year.nil? & !(@years.include? notice.year)
    end
    @years.sort!
  end

  # counts the number of crimes per year
  def get_crimes_per_year
    @years.each do |year|
      @crime_per_year[year] = 0
    end
    all_notices.each do |notice|
      value = @crime_per_year[notice.year].to_i
      @crime_per_year[notice.year] = value + 1 if @crime_per_year.key? notice.year
    end
  end
end
