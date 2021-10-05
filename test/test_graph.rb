require 'minitest/autorun'
require './lib/graph'
require 'ruby2d'

# Test fixture for Graph Class
class TestGraph < Minitest::Test
  def setup
    @graph = Graph.new
  end

  # Has x attribute
  def test_has_x
    assert_respond_to @graph, :x
  end

  # Has y attribute
  def test_has_y
    assert_respond_to @graph, :y
  end

  # Has graph attribute
  def test_has_graph
    assert_respond_to @graph, :graph
  end

  # normal input
  def test_set_time_1159am
    time = '11:59 a.m.'
    time_expected = 11 + 59 / 60.0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # normal input
  def test_set_time_1159pm
    time = '11:59 p.m.'
    time_expected = 23 + 59 / 60.0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # normal input
  def test_set_time_140pm
    time = '1:40 p.m.'
    time_expected = 1 + 12 + 40 / 60.0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # boundary - 12am
  def test_set_time_12am
    time = '12 a.m.'
    time_expected = 0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # boundary - 12:00am
  def test_set_time_1200am
    time = '12:00 a.m.'
    time_expected = 0.0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # boundary - 12:01am
  def test_set_time_1201am
    time = '12:01 a.m.'
    time_expected = 1 / 60.0
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # boundary - 12pm
  def test_set_time_12pm
    time = '12 p.m.'
    time_expected = 12
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end

  # boundary - 12pm
  def test_set_time_1201pm
    time = '12:01 p.m.'
    time_expected = 12 + (1 / 60.0)
    time_output = Graph.set_time time
    assert_equal time_expected, time_output
  end
end
