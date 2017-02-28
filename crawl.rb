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
    @form = @page.forms.first
  end

  # Author: Sunny Patel   2/21
  # Displays all the fields for the first form
  def display_fields
    @form.fields.each {|f| puts f.name}
  end

  # Author Sunny Patel    2/21
  # Fills in keywords search bar on the posting page
  # Modifications:
  # Sunny Patel 2/22: Fixed to switch page to submitted form
  def search(query)
    @form['query'] = query
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Fills in university title search bar
  def university_title(query)
    @form['578'] = query
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Fills in working title search bar
  def working_title(query)
    @form['577'] = query
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Fills in job opening number search bar
  def job_opening_number(query)
    @form['579'] = query
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Selects a location in the form
  # 1 = columbus
  # 2 = lima
  # 3 = mansfield
  # 4 = marion
  # 5 = newark
  # 6 = wooster
  # 8 = delaware
  # 9 = springfield
  # 10 = piketon
  # 11 = dayton
  def location(value)
    @form['591'] = value
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Selects a job category
  # 2 = instructional/faculty
  # 3 = adminstrative and professional
  # 4 = information technology
  # 5 = research
  # 6 = civil service
  def job_category(value)
    @form['580'] = value
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Selects from full/part time category
  # 4 = full time
  # 5 = part time
  # 6 = temporary
  # 7 = term
  def job_time(value)
    @form['581'] = value
  end

  # Author Sunny Patel & Kenton Steiner   2/23
  # Selects a time period to search
  # "day" = last day
  # "week" = last week
  # "month" = last month
  def posted_within(value)
    @form['query_v0_posted_at_date'] = value
  end

  # Author Sunny Patel    2/23
  # Submits form
  def submit_form
    @page = @form.submit
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
    job_array = get_position_single_page
    # Loop until there is no next page
    while link = next_page
      @page = link.click
      job_array += get_position_single_page
    end
    # restores page to initial page
    @page = initial_page
    job_array
  end

  # Author Sunny Patel    2/23
  # Prints all the information in a super_array
  def print_info_array(super_array)
    super_array.each do |sub_array|
      sub_array.each {|item| puts item}
      puts
    end
  end

  # Author Sunny Patel    2/23
  # Returns an array with all the position links on a single page
  def get_position_links
    # Get all links that have the text: "View Details"
    links = @page.links_with(:text => /View Details/)
    href_links = []
    # convert all links into an appropriate html link
    links.each { |link| href_links << 'https://www.jobsatosu.com' + link.href }
    href_links
  end

  private
  # Author Sunny Patel    2/22
  # Get the text of all selectors that match search
  # expectedCount the number of elements expected in 1 subarray
  # RETURNS: A (super)array of (sub)arrays that contains all the information for 1 position
  # Modifications:
  # Sunny Patel 2/22: Returns an array so that the information can be accessed
  def search_for_selectors(search, expectedCount)
    # get all links for current page
    links = get_position_links
    # count used to put all information for 1 position in 1 array
    count = 1
    # link_index used to add the appropriate links to array
    link_index= 0
    # Sub array that will hold the information of 1 position
    job_content = []
    # Super array that holds information of all positions
    job_array = []
    @page.search(search).each do |selector|
      job_content << selector.text.strip
      if count % expectedCount == 0
        job_content << links[link_index]
        link_index += 1
        job_array << job_content
        job_content = []
      end
      count += 1
    end
    # Return super array
    job_array
  end

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
end



