require_relative 'notice'
require_relative 'page'

# class for creating graphs using Gruff
class Graph
  attr_accessor :x, :y, :graph

  def initialize
    @x = []
    @y = []
  end

  # creates a scatterplot graph for crime time
  def create_scatterplot(graph, scrape, filename)
    @graph = Gruff::Scatter.new
    get_data_points(graph, scrape)
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

  # creates a bargraph for number of crimes each year
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

  # the look of the graph
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

  # the look for the axis of scatterplot
  def set_axis_style_scatterplot(scrape)
    @graph.x_axis_label = 'Year of Crime'
    @graph.y_axis_label = 'Time of Crimes'

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

  # the look for the axis of bar graph
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

  # get the time in 24 hour clock
  def set_time(time)
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

  # sets the x & y for the graph
  def get_data_points(graph, scrape)
    scrape.all_notices.each do |notice|
      # checks if time is string with all white spaces
      # checks if there is a date
      @y << graph.set_time(notice.time) if !notice.date.nil? && !notice.time.nil?
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
