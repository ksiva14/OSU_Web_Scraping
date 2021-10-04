require_relative './notice'
require_relative './page'

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

  # sets the x & y for the graph
  def get_data_points(_graph, scrape)
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

# DELETE EVERYTHING BELOW LATER
#
# LINKS
# https://github.com/topfunky/gruff/blob/master/lib/gruff/base.rb
# https://github.com/topfunky/gruff/blob/master/test/test_scatter.rb
# https://www.rubydoc.info/github/topfunky/gruff
# https://www.ruby-toolbox.com/projects/gruff
#
# EXAMPLE OF SCATTERPLOT GRAPHS
# datasets = [
#   [:Chuck, [20, 10, 5, 12, 11, 6, 10, 7], [5, 10, 19, 6, 9, 1, 14, 8]],
#   [:Brown, [5, 10, 20, 6, 9, 12, 14, 8], [20, 10, 5, 12, 11, 6, 10, 7]],
#   [:Lucy, [19, 9, 6, 11, 12, 7, 15, 8], [6, 11, 18, 8, 12, 8, 10, 6]]
# ]

# g = Gruff::Scatter.new('1000x500')
# g.top_margin = 0
# g.hide_legend = true
# g.hide_title = true
# g.marker_font_size = 10
# g.theme = {
#   colors: ['#12a702', '#aedaa9'],
#   marker_color: '#dddddd',
#   font_color: 'black',
#   background_colors: 'white'
# }

# # Points style
# g.circle_radius = 1
# g.stroke_width = 0.01

# # Axis labels
# g.x_label_margin = 40
# g.bottom_margin = 60
# g.disable_significant_rounding_x_axis = true
# g.use_vertical_x_labels = true
# g.show_vertical_markers
# g.marker_x_count = 50 # One label every 2 days
# g.x_axis_label_format = lambda do |value|
#   Time.at(value).strftime('%d.%m.%Y')
# end
# g.y_axis_increment = 1
# g.y_axis_label_format = lambda do |value|
#   format('%.1f', value)
# end

# # Fake data (100 days, random times of day between 5 and 16)
# srand 872
# r = Random.new(269_155)
# time = Time.mktime(2000, 1, 1)
# y_values = (0..100).map { 5 + r.rand(12) }
# x_values = (0..100).map { |i| time.to_i + i * 3600 * 24 }
# g.data('many points', x_values, y_values)
# g.write('scatter_custom_label_format.png')
