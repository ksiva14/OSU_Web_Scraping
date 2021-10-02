require_relative 'notice'
require_relative 'page'

class Graph
  attr_accessor :x, :y, :scatter_graph

  def initialize
    @x = []
    @y = []
  end

  def create_scatterplot(page_array, graph)
    @scatter_graph = Gruff::Scatter.new
    get_data_points(page_array, graph)
    set_graph_properties
    @scatter_graph.data('crime time', @x, @y)
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

  # the look of the graph
  def set_graph_properties
    @scatter_graph.title = '\"Hot Time\" for Crimes'
    @scatter_graph.hide_legend = true
    @scatter_graph.theme = {
      colors: ['#12a702', '#aedaa9'],
      font_color: 'black',
      background_colors: 'white'
    }

    # Points style
    @scatter_graph.circle_radius = 3
    @scatter_graph.stroke_width = 0.01

    set_axis_style
  end

  # the look fo the axis
  def set_axis_style
    # 24:00 format for y-axis
    @scatter_graph.y_axis_increment = 1
    @scatter_graph.y_axis_label_format = lambda do |value|
      if value < 10
        format('0%d:00', value)
      else
        format('%d:00', value)
      end
    end
    # year for x-axis
    @scatter_graph.x_axis_increment = 1
    @scatter_graph.x_axis_label_format = lambda do |value|
      format('%d', value)
    end
  end

  # sets the x & y for the graph
  def get_data_points(page_array, graph)
    @year = []
    page_array.each do |page|
      page.notices.each do |notice|
        # checks if time is string with all white spaces
        @y << graph.set_time(notice.time) unless notice.time.to_s.strip.empty?
        # does not add the same year
        @year << notice.year if (notice.year != 0) & !(@year.include? notice.year)
      end
    end
    @year = @year.sort
    @x = (1..@y.length).map { rand(3) }
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
