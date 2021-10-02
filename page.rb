# class for page object
class Page
  attr_reader :page, :title, :notice_links

  def initialize(page_link, all_notices)
    @page = Mechanize.new.get page_link
    @title = @page.css("div[class='field__items']")
    @notice_links = []
    create_notice_links
    create_notice all_notices
  end

  # gets the links for the notices
  def create_notice_links
    @title.each do |i|
      if i.css('a').text.include? 'Neighborhood Safety Notice'
        @notice_links << "https://dps.osu.edu#{i.css('a')[0]['href']}"
      end
    end
  end

  # gets all the notices from the page to retrieve data from
  def create_notice(all_notices)
    @notice_links.each do |link|
      all_notices << (Notice.new link)
    end
  end
end