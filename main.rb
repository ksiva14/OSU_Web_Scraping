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
puts 'Retrieving Data...'
# mechanize first page to start retriving data from website
scrape.page_array << Page.new(link, scrape.all_notices)
# create notice for each page
scrape.get_num_of_pages(scrape.page_array[0].page)
scrape.create_link(link)
scrape.collect_data
puts 'All Data Retrieved.'

# Graph for displaying crime time - creates a png of the graph
puts 'Creating Graph...'
crime_time_graph = Graph.new
crime_time_graph.create_scatterplot crime_time_graph, scrape
crime_time_graph.scatter_graph.write('crime_time.png')
puts 'Graph has been created.'
