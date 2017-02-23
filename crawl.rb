require 'mechanize'
require 'nokogiri'
# Author: Sunny Patel   2/21
class Scraper
  @@url = 'https://www.jobsatosu.com/postings/search'
  @@basicInformationCount = 6
  # Author: Sunny Patel   2/21
  def initialize
    @agent = Mechanize.new
    @page = @agent.get(@@url)
  end

  # Author: Sunny Patel   2/21
  # Displays all the fields for the first form
  def display_fields
    form = get_form
    form.fields.each {|f| puts f.name}
  end

  # Author Sunny Patel    2/21
  # Fills in the searchbar on the posting page and submits form
  # Modifications:
  # Sunny Patel 2/22: Fixed to switch page to submitted form
  def search(query)
    form = get_form
    form['query'] = query
    @page = form.submit
  end

  def location(value)
    form = get_form
    form['591'] = value
    @page = form.submit
  end

  # Author Sunny Patel    2/22
  # Get the text of all selectors that match search
  # expectedCount the number of elements expected in 1 subarray
  # RETURNS: A (super)array of (sub)arrays that contains all the information for 1 position
  # Modifications:
  # Sunny Patel 2/22: Returns an array so that the information can be accessed
  def search_for_selectors(search, expectedCount)
    count = 1
    # Sub array that will hold the information of 1 position
    position_array = []
    # Super array that holds information of all positions
    positions_array = []
    @page.search(search).each do |selector|
      position_array << selector.text.strip
      if count % expectedCount == 0
        positions_array << position_array
        position_array = []
      end
      count += 1
    end
    # Return super array
    positions_array
  end

  # Author Sunny Patel    2/22
  # Will pretty print the page
  def pretty_print_page
    pp @page
  end

  # Author Sunny Patel    2/22
  # RESTORES: @page
  # RETURNS: Array that contains subarrays which contain all the basic information for 1 position from all pages
  def get_position_info
    initial_page = @page
    position_array = get_position_single_page
    # Loop until there is no next page
    while link = next_page
      @page = link.click
      position_array = position_array + get_position_single_page
    end
    # restores page to initial page
    @page = initial_page
    position_array
  end

  # Author Sunny Patel    2/23
  # Prints all the information in a super_array
  def print_info_array(super_array)
    puts super_array.class
    puts
    super_array.each do |sub_array|
      sub_array.each {|item| puts item}
      puts
    end
  end

  private
  # Author Sunny Patel    2/22
  # Get an array of subarrays of the all the basic information for 1 position from 1 page
  def get_position_single_page
    search_for_selectors('//*[(@id = "search_results")]//tr[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]//td', @@basicInformationCount)
  end

  # Author Sunny Patel    2/22
  # RETURNS: the next page OR NIL if page does not exist
  def next_page
    @page.link_with(:text => /Next/)
  end

  # Author: Sunny Patel   2/21
  def get_form
    @page.forms.first
  end
end

# REMEMBER TO CLEAN UP THIS BOTTOM PORTION
jobSite = Scraper.new
