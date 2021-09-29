# class for notice object
class Notice
    attr_reader :time, :date, :location, :description
  
    
    def initialize(link)
        noticeMech = Mechanize.new
        noticePage = noticeMech.get link 
        
        
        noticeDescription = noticePage.css("div[class='field__items']")[3].css('p')[1].text
        puts "*******************"
        puts noticeDescription

        # still trying to figure out how to consistenly extract time and date 

        #@description = noticeDescription
        #@date = noticeDescription.split(',')[0].split(' ')[1]
        #@time = noticeDescription.split(',')[1].split(' ')[2] + ' ' + noticeDescription.split(',')[1].split(' ')[3]
        #@location = "TO DO"
        
    end

    
  
  end