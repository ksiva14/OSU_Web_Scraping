# class for notice object
class Notice
  attr_reader :time, :date, :location, :description, :year

  def initialize(link)
    notice_page = Mechanize.new.get link

    notice_paragraphs = notice_page.css("div[class='field__items']")[3].css('p')
    @description = 'none'
    notice_paragraphs.each do |i|
      @description = i.text if i.text.include?('a.m.') || i.text.include?('p.m.')
    end

    retrieve_date
    retrieve_year
    retrieve_time
    @location = @description.scan(/([0-9A-Za-z]+) (Avenue|St |Ave|Street|Court|Square|Place)/)

    # puts '*****'
    # puts "#{@date} --- #{@time}"
    # puts @location[0]
    # puts @location[1]
    # puts '*****'
  end

  # retrieve the date of crime
  def retrieve_date
    @date = @description[%r{\d+/\d+/\d+}]
    # checks that the date is not empty
    @date = nil if @date.to_s.strip.empty?
  end

  # retrieve year from the date
  def retrieve_year
    if @date.nil?
      @year = nil
    else
      temp = @date.to_s.split '/'
      # @year = 0 if temp[2] is blank/no date
      @year = temp[2].to_i
      # prevent addition of 2000 if 0
      @year += 2000 if !@year.zero? & (@year < 2000)
    end
  end

  # retrieve the time of crime
  def retrieve_time
    @time = @description[/\d+(:\d+)* (a|p)\.m\./]
    @time = nil if @time.to_s.strip.empty?
  end
end
