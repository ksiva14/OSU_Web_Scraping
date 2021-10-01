require 'mechanize'
require 'nokogiri'
require_relative 'Notice'
require_relative 'graph'

# to install
# sudo apt-get install libmagickwand-dev
# gem install gruff
require 'gruff'

# add https://dps.osu.edu/news?tag%5B15%5D=15&page=1
# change 1 to i????? to iterate throught the pages.

page_link = '&page='
mech = Mechanize.new
page = mech.get 'https://dps.osu.edu/news?tag%5B15%5D=15'
titles = page.css("div[class='field__items']")
noticeLinks = []
titles.each do |i|
  if i.css('a').text.include? 'Neighborhood Safety Notice'
    link = 'https://dps.osu.edu' + i.css('a')[0]['href']
    noticeLinks << link
  end
end

notices = []
noticeLinks.each do |i|
  notices << (Notice.new i)
end

# Graph for displaying crime time
# creates a png of the graph
crime_time_graph = Graph.new
notices.each_index do |i|
  crime_time_graph.y << crime_time_graph.set_time(notices[i].time)
end
crime_time_graph.x = (1..crime_time_graph.y.length).map { 1 }
crime_time_graph.scatter_graph.data('crime time', crime_time_graph.x, crime_time_graph.y)
crime_time_graph.scatter_graph.write('crime_time.png')
