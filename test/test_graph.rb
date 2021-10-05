require 'minitest/autorun'
require '../lib/graph'
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
  def test_has_x
    assert_respond_to @graph, :graph
  end

  def test_set_time_hour
    time = '11 a.m.'
    hour = Graph.set_time(time)
    assert_equal 11, hour
  end
end
