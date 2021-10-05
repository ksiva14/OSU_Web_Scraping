require 'minitest/autorun'
require '../lib/notice'
require 'mechanize'

# Test fixture for Notice Class
class TestNotice < Minitest::Test
  def setup
    @notice = Notice.new('https://dps.osu.edu/news/2021/09/26/neighborhood-safety-notice-september-26-2021')
  end

  # Has time attribute
  def test_has_time
    assert_respond_to @notice, :time
  end

  # Has date attribute
  def test_has_date
    assert_respond_to @notice, :date
  end

  # Has location attribute
  def test_has_location
    assert_respond_to @notice, :location
  end

  # Has description attribute
  def test_has_description
    assert_respond_to @notice, :description
  end

  # Has year attribute
  def test_has_year
    assert_respond_to @notice, :year
  end

  # Remembers time Attribute
  def test_time
    assert_equal '3:18 a.m.', @notice.time
  end

  # Remembers date Attribute
  def test_date
    assert_equal '9/26/2021', @notice.date
  end

  # Remembers location Attribute
  def test_location
    assert_equal [%w[Indianola Avenue], %w[Woodruff Avenue]], @notice.location
  end

  # Remembers description Attribute
  def test_description
    assert_equal 'On 9/26/2021, at approximately 3:18 a.m., three Ohio State students were walking southbound on Indianola Avenue, near Woodruff Avenue, when a black Honda Accord stopped next to them. Two males, reported to be between the ages of 17 and 21, produced handguns, and demanded the victims’ property. The suspects exited the vehicle to commit the robbery, then returned to the car and fled the area along with their driver. No injuries were reported.',
                 @notice.description
  end

  # challenge case - 12am
  def test_retrieve_time_12am
    @notice.description = 'lalala 12 a.m. lalalsssa'
    expected = '12 a.m.'
    @notice.retrieve_time
    result = @notice.time
    assert_equal expected, result
  end

  # challenge case - 12pm
  def test_retrieve_time_12pm
    @notice.description = 'lalala 12 p.m. lalalsssa'
    expected = '12 p.m.'
    @notice.retrieve_time
    result = @notice.time
    assert_equal expected, result
  end

  # normal input - 12:59am
  def test_retrieve_time_1259am
    @notice.description = 'lalala 12:59 a.m. lalalsssa'
    expected = '12:59 a.m.'
    @notice.retrieve_time
    result = @notice.time
    assert_equal expected, result
  end

  # normal input - 11:59pm
  def test_retrieve_time_1159pm
    @notice.description = 'lalala 11:59 p.m. lalalsssa'
    expected = '11:59 p.m.'
    @notice.retrieve_time
    result = @notice.time
    assert_equal expected, result
  end

  # normal input - 10/10/20
  def test_retrieve_date_10_10_20
    @notice.description = 'lalala 10/10/20 lalalsssa'
    expected = '10/10/20'
    @notice.retrieve_date
    result = @notice.date
    assert_equal expected, result
  end

  # challenge case - 1/11/21
  def test_retrieve_date_1_11_21
    @notice.description = 'lalala 1/11/21 lalalsssa'
    expected = '1/11/21'
    @notice.retrieve_date
    result = @notice.date
    assert_equal expected, result
  end

  # challenge case - 5/1/19
  def test_retrieve_date_5_1_19
    @notice.description = 'lalala 5/1/19 lalalsssa'
    expected = '5/1/19'
    @notice.retrieve_date
    result = @notice.date
    assert_equal expected, result
  end

  # normal input - 12/12/2020
  def test_retrieve_date_12_12_2020
    @notice.description = 'lalala 12/12/2020 lalalsssa'
    expected = '12/12/2020'
    @notice.retrieve_date
    result = @notice.date
    assert_equal expected, result
  end

  # normal input - 12/12/2020
  def test_retrieve_year_12_12_2020
    @notice.description = 'lalala 12/12/2020 lalalsssa'
    expected = 2020
    @notice.retrieve_date
    @notice.retrieve_year
    result = @notice.year
    assert_equal expected, result
  end

  # normal input - 12/12/20
  def test_retrieve_year_12_12_20
    @notice.description = 'lalala 12/12/20 lalalsssa'
    expected = 2020
    @notice.retrieve_date
    @notice.retrieve_year
    result = @notice.year
    assert_equal expected, result
  end

  # normal input - Lane Avenue and High Street
  def test_retrieve_location_two_streets
    @notice.description = 'lalala Lane Avenue and High Street lalalsssa'
    expected = [['Lane', 'Avenue'], ['High', 'Street']]
    @notice.retrieve_location
    result = @notice.location
    assert_equal expected, result
  end

  # challenge case - Lane Ave and High St
  def test_retrieve_location_two_streets_short_descriptors
    @notice.description = 'lalala Lane Ave and High St lalalsssa'
    expected = [['Lane', 'Ave'], ['High', 'St ']]
    @notice.retrieve_location
    result = @notice.location
    assert_equal expected, result
  end

  # challenge case - Lane and 18th avenues
  def test_retrieve_location_two_streets_together
    @notice.description = 'lalala Lane and 18th avenues lalalsssa'
    expected = ['Lane', '18th']
    @notice.retrieve_location
    result = @notice.location
    assert_equal expected, result
  end

  # challenge case - Lane and High
  def test_retrieve_location_two_streets_no_descriptors
    @notice.description = 'lalala Lane and High lalalsssa'
    expected = ['Lane', 'High']
    @notice.retrieve_location
    result = @notice.location
    assert_equal expected, result
  end

end
