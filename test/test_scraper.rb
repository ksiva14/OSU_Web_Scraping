require 'minitest/autorun'
require '../lib/scraper'

# Test fixture for Scraper Class
class TestScraper < Minitest::Test
  def setup
    @scraper = Scraper.new
  end

  # Has number_of_pages attribute
  def test_has_number_of_pages
    assert_respond_to @scraper, :number_of_pages
  end

  # Has page_array attribute
  def test_has_page_array
    assert_respond_to @scraper, :page_array
  end

  # Has all_notices attribute
  def test_has_all_notices
    assert_respond_to @scraper, :all_notices
  end

  # Has years attribute
  def test_has_years
    assert_respond_to @scraper, :years
  end

  # Has crime_per_year attribute
  def test_has_crime_per_year
    assert_respond_to @scraper, :crime_per_year
  end

end
