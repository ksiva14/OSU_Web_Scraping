require 'minitest/autorun'
require '../lib/page'
require 'mechanize'

# Test fixture for Page Class
class TestPage < Minitest::Test

  def setup
    @page = Page.new('https://dps.osu.edu/news', [])
  end

  # Has page attribute
  def test_has_page
    assert_respond_to @page, :page
  end

  # Has title attribute
  def test_has_title
    assert_respond_to @page, :title
  end

  # Has notice_links attribute
  def test_has_notice_links
    assert_respond_to @page, :notice_links
  end

end
