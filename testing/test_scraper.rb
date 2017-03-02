require_relative '../scraper'
require "test/unit"

class TestScraper < Test::Unit::TestCase

  # Author Tony Su    2/27
  def test_init
    assert_nothing_raised {Scraper.new}
  end

  # Author Tony Su    2/27
  def test_get_position_links
    a = Scraper.new
    link = a.get_position_links
    assert_equal(30,link.length, "Expected number of link in a single page: ")
  end

  # Author Tony Su    2/27
  def test_get_position_links_02
    a = Scraper.new
    link = a.get_position_links
    link.each do |a|
      assert_match /https:\/\/www.jobsatosu.com.*/, a ,"The link must be a link to jobsarosu.com"
    end

  end

end