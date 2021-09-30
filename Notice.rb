# class for notice object
class Notice
    attr_reader :time, :date, :location, :description
  
    
    def initialize(link)
        noticeMech = Mechanize.new
        noticePage = noticeMech.get link 
        
        
        noticeParagraphs = noticePage.css("div[class='field__items']")[3].css('p')
        noticeDescription = 'none'
        noticeParagraphs.each { |i|
        noticeDescription = i.text if (i.text.include?('a.m.') || i.text.include?('p.m.'))
        }
        
        @date = noticeDescription[/\d+\/\d+\/\d+/]
        @time = noticeDescription[/\d+(:\d+)* (a|p)\.m\./]
        
        @location = noticeDescription.scan(/([0-9A-Za-z]+) (Avenue|St |Ave|Street|Court|Square|Place)/)
        puts '*****'
        puts @date
        puts @location[0]
        puts @location[1]
        puts '*****'


        
    end

    
  
  end