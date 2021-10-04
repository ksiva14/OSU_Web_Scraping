require 'mechanize'
require 'nokogiri'
require 'gruff'
require_relative './lib/notice'
require_relative './lib/graph'
require_relative './lib/page'
require_relative './lib/scraper'
require_relative './lib/htmltable'

# to install
# sudo apt-get install libmagickwand-dev
# gem install gruff

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
crime_time_graph.create_scatterplot crime_time_graph, scrape, './lib/graphs/crime_time.png'

num_crimes_graph = Graph.new
num_crimes_graph.create_bargraph scrape, './lib/graphs/num_crimes.png'
puts 'Graph has been created.'

f = File.new('./main.html', 'w')
html = Htmltable.new

# output html page after scraping data and creating graphs
html.create_page f, scrape.all_notices
