require 'mechanize'
require 'nokogiri'
require_relative 'notice'
require_relative 'graph'
require_relative 'page'
require_relative 'scraper'

# to install
# sudo apt-get install libmagickwand-dev
# gem install gruff
require 'gruff'

link = 'https://dps.osu.edu/news?tag%5B15%5D=15'

scrape = Scraper.new
# mechanize first page to start retriving data from website
scrape.page_array << Page.new(link)
# create notice for each page
scrape.get_num_of_pages(scrape.page_array[0].page)
scrape.create_link(link)

notices = scrape.page_array[0].notices
# Graph for displaying crime time
# creates a png of the graph
crime_time_graph = Graph.new
notices.each_index do |i|
  crime_time_graph.y << crime_time_graph.set_time(notices[i].time)
end
crime_time_graph.x = (1..crime_time_graph.y.length).map { 1 }
crime_time_graph.scatter_graph.data('crime time', crime_time_graph.x, crime_time_graph.y)
crime_time_graph.scatter_graph.write('crime_time.png')
