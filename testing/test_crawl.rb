require_relative '../crawl'
require "test/unit"

class TestCrawl < Test::Unit::TestCase

  # Author Tony Su    2/27
  # Test the intialization to make sure no exception is raised. 
  def test_init
    assert_nothing_raised {Scraper.new}
  end

  # Author Tony Su    2/27
  # test the length of the array returned by get_position_links, The length should be 30 as each page can   display 30 positions.
  def test_get_position_links
    a = Scraper.new
    link = a.get_position_links
    assert_equal(30,link.length, "Expected number of link in a single page: ")
  end

  # Author Tony Su    2/27
  # test the links in the array. The link must be a link to the website jobatosu
  def test_get_position_links_02
    a = Scraper.new
    link = a.get_position_links
    link.each do |a|
      assert_match /https:\/\/www.jobsatosu.com.*/, a ,"The link must be a link to jobsatosu.com"
    end

  end

end
