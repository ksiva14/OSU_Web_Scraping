# class for notice object
class Notice
  attr_reader :time, :date, :location, :description

  def initialize(link)
    notice_page = Mechanize.new.get link

    notice_paragraphs = notice_page.css("div[class='field__items']")[3].css('p')
    @description = 'none'
    notice_paragraphs.each do |i|
      @description = i.text if i.text.include?('a.m.') || i.text.include?('p.m.')
    end

    @date = @description[%r{\d+/\d+/\d+}]
    @time = @description[/\d+(:\d+)* (a|p)\.m\./]
    @location = @description.scan(/([0-9A-Za-z]+) (Avenue|St |Ave|Street|Court|Square|Place)/)

    # puts '*****'
    # puts @date
    # puts @time
    # puts @location[0]
    # puts @location[1]
    # puts '*****'
  end
end
