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
    retrieve_location

    # puts '*****'
    # puts "#{@date} --- #{@time}"
    # puts @location
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

  # retrieve the location of crime
  def retrieve_location
    @location = @description.scan(/([0-9A-Za-z]+) (Avenue|St\.|St |Ave\.*|Street|Court|Square|Place)/)

    # if first attempt cannot find any street names in traditional format, look for paired streets
    if @location.length == 0
      streets = @description[/[a-zA-Z0-9]+ and [a-zA-Z0-9]+ (avenues|streets)/]
      unless streets.nil?
        streets = streets.split ' '
        @location[0] = streets[0]
        @location[1] = streets[2]
      end
    end

    # if second attempt cannot find any streets in paired format, look for any streets on/near campus listed
    if @location.length == 0
      # puts 'third'
      streets = %w[8th 9th 10th 11th Chittenden 12th 13th 14th 15th 16th 17th 18th Woodruff Frambes
                   Lane Norwich Pearl Northwood Oakland Patterson Maynard Blake Neil High Indianola Summit 4th]
      streets.each { |i| @location << i if @description.include? i }
    end

    # set location to be two streets to eliminate duplicates
    @location = @location[0, 2]
  end
end