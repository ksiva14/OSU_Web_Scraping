# Authors: Zheng Ji Tan, Tyler Frantz, Karthick Sivasubramanian, Justin King

require 'mechanize'
require 'nokogiri'
require 'gruff'
require_relative './lib/notice'
require_relative './lib/graph'
require_relative './lib/page'
require_relative './lib/scraper'
require_relative './lib/htmltable'

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
# scatterplot for showing the time crimes usually occur
Graph.new.create_scatterplot scrape, './lib/graphs/crime_time.png'
# bar graph for showing the number of crimes each year
Graph.new.create_bargraph scrape, './lib/graphs/num_crimes.png'
puts 'Graph has been created.'

# output html page after scraping data and creating graphs
file = File.new('./index.html', 'w')
Htmltable.new.create_page file, scrape.all_notices
