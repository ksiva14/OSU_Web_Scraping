require_relative 'notice'
require_relative 'page'

# class for creating graphs using Gruff
class Graph
  attr_accessor :x, :y, :graph

  # Constructor Init
  def initialize
    @x = []
    @y = []
  end

  # Function to create a scatterplot graph for crime time
  # Parameter scrape: scraper used in main
  # Parameter filename: name of file to write to
  def create_scatterplot(scrape, filename)
    @graph = Gruff::Scatter.new
    get_data_points(scrape)
    # general style of graph
    set_graph_properties '\"Hot Time\" for Crimes'
    # Points style
    @graph.circle_radius = 4
    @graph.stroke_width = 0.01
    # axis style
    set_axis_style_scatterplot scrape
    @graph.data 'crime time', @x, @y
    @graph.write filename
  end

  # Function to create a bargraph for number of crimes each year
  # Parameter scrape: scraper used in main
  # Parameter filename: name of file to write to
  def create_bargraph(scrape, filename)
    @graph = Gruff::Bar.new
    # general style of graph
    set_graph_properties 'Number of Crimes Per Year at OSU'
    # bar style
    @graph.spacing_factor = 0.1
    @graph.group_spacing = 20
    # axis style
    set_axis_style_bar scrape
    @graph.data scrape.years, scrape.crime_per_year.values
    @graph.write filename
  end

  # Function to set the look of the graph
  # Parameter graph_title: stored title of the graph
  def set_graph_properties(graph_title)
    @graph.title = graph_title
    @graph.hide_legend = true
    @graph.theme = {
      colors: ['#12a702', '#aedaa9'],
      font_color: 'black',
      background_colors: 'white'
    }
    # add some space to the right of graph in .png
    @graph.right_margin = 50
  end

  # Function to set the look for the axis of scatterplot
  # Parameter scrape: scraper used in main
  def set_axis_style_scatterplot(scrape)
    @graph.x_axis_label = 'Year of Crime'
    @graph.y_axis_label = 'Time of Crime'

    # 24:00 format for y-axis
    @graph.y_axis_increment = 1
    @graph.y_axis_label_format = lambda do |value|
      if value < 10
        format('0%d:00', value)
      else
        format('%d:00', value)
      end
    end

    # year as x-axis labels
    @graph.x_axis_increment = 1
    @graph.x_axis_label_format = lambda do |value|
      format('%d', scrape.years[value - 1])
    end
  end

  # Function to set the look for the axis of bar graph
  # Parameter scrape: scraper used in main
  def set_axis_style_bar(scrape)
    @graph.x_axis_label = 'Year of Crime'
    @graph.y_axis_label = 'Number of Crimes'

    @graph.y_axis_increment = 2
    @graph.maximum_value = 40
    @graph.minimum_value = 0

    # year as x-axis labels
    tmp_label = {}
    scrape.years.length.times do |i|
      tmp_label[i] = scrape.years[i]
    end
    @graph.x_axis_increment = 1
    @graph.labels = tmp_label

    # bar values
    @graph.show_labels_for_bar_values = true
    @graph.label_formatting = lambda do |value|
      value.to_i.to_s
    end
  end

  # Function to get the time in 24 hour clock
  # Parameter time: time pulled from article
  def self.set_time(time)
    time_holder = []
    if time.to_s.include? ':'
      # eg: 11:54 am
      time_holder = time.to_s.split(':')
      have_minute = true
    else
      # eg: 11 am
      time_holder = time.to_s.split(' ')
      have_minute = false
    end

    # seperate the hour
    hour = 12
    if time.to_s.include? 'p.m.'
      hour = time_holder[0].to_i + 12 unless time_holder[0].to_i == 12
    else
      hour = time_holder[0].to_i
    end

    # seperate the minute
    minute = 0.0
    if have_minute
      time_holder = time_holder[1].to_s.split ' '
      minute = time_holder[0].to_i / 60.0
    end

    # hour.minute
    hour + minute
  end

  # Function to set the x & y for the graph
  # Parameter scrape: scraper used in main
  def get_data_points(scrape)
    scrape.all_notices.each do |notice|
      # checks if time is string with all white spaces
      # checks if there is a date
      @y << Graph.set_time(notice.time) if !notice.date.nil? && !notice.time.nil?
    end
    # let the oldest data be at front
    @y.reverse!

    # creates a range of x-value with an incremenet of 1
    value = 1
    scrape.crime_per_year.each_value do |count|
      count.times { @x << value }
      value += 1
    end
  end
end
