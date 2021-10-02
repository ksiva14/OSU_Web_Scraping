require 'mechanize'
require 'nokogiri'
require_relative 'notice'
require_relative 'graph'
require_relative 'page'
require_relative 'scraper'
require_relative 'htmltable'

# to install
# sudo apt-get install libmagickwand-dev
# gem install gruff
require 'gruff'

link = 'https://dps.osu.edu/news?tag%5B15%5D=15'

f = File.new("./table.txt", "w")
html = Htmltable.new
#output html header to file
html.create_header f
#loop to output elements to table
html.output_element f
#output html footer to file
html.create_footer f


scrape = Scraper.new
# mechanize first page to start retriving data from website
scrape.page_array << Page.new(link)
# create notice for each page
scrape.get_num_of_pages(scrape.page_array[0].page)
scrape.create_link(link)

# Graph for displaying crime time - creates a png of the graph
puts 'Creating Graph...'
crime_time_graph = Graph.new
crime_time_graph.create_scatterplot scrape.page_array, crime_time_graph
crime_time_graph.scatter_graph.write('crime_time.png')
puts 'Graph has been created.'



f.close