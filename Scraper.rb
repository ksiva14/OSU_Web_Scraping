require 'mechanize'
require 'nokogiri'
require_relative 'Notice'






mech = Mechanize.new
page = mech.get 'https://dps.osu.edu/news?tag%5B15%5D=15'
titles = page.css("div[class='field__items']")
noticeLinks = []
titles.each {|i| 
    if i.css("a").text.include? 'Neighborhood Safety Notice'
        link = 'https://dps.osu.edu' + i.css("a")[0]['href'] 
        noticeLinks << link
    end
}



notices = []
noticeLinks.each { |i| 
    notices << (Notice.new i)
} 







