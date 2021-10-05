require_relative 'notice'
# class for page object
class Page
  attr_reader :page, :title, :notice_links

  # Constructor Init
  def initialize(page_link, all_notices)
    @page = Mechanize.new.get page_link
    @title = @page.css("div[class='field__items']")
    @notice_links = []
    create_notice_links
    create_notice all_notices
  end

  # Function to get the links for the notices
  def create_notice_links
    @title.each do |i|
      if i.css('a').text.include? 'Neighborhood Safety Notice'
        @notice_links << "https://dps.osu.edu#{i.css('a')[0]['href']}"
      end
    end
  end

  # Function to get all the notices from the page to retrieve data from
  # Parameter all_notices: all notice links, new notice link added on
  def create_notice(all_notices)
    @notice_links.each do |link|
      all_notices << (Notice.new link)
    end
  end
end
