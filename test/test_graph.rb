require 'minitest/autorun'
require './lib/graph'
require 'ruby2d'

# Test fixture for Player Class
class TestGraph < Minitest::Test
  def setup
    # @graph = Graph.new
  end

  # Has name attribute
  def test_set_time_hour
    time = '11 a.m.'
    hour = Graph.set_time(time)
    assert_equal 11, hour
  end
end
