require 'mechanize'
require 'nokogiri'
# Author: Sunny Patel   2/21
class Scraper
  @@url = 'https://www.jobsatosu.com/postings/search'
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

  # Author Sunny Patel    2/22
  # Only selects selector expressions
  # Will print the text of all selectors that match search
  # expectedCount is a number used to print spaces between blocks of information
  def search_for_selectors(search, expectedCount)
    count = 1
    @page.search(search).each do |selector|
      puts selector.text.strip
      puts if count % expectedCount == 0
      count += 1
    end
  end

  # Author Sunny Patel    2/22
  # Will pretty print the page
  def pretty_print_page
    pp @page
  end

  # Author Sunny Patel    2/22
  # Prints titles and salaries from every page possible
  # Restores: @page
  def print_all_titles_and_salaries
    initial_page = @page
    print_title_and_salary
    while link = next_page
      @page = link.click
      print_title_and_salary
    end
    # restores page to initial page
    @page = initial_page
  end

  # Author Sunny Patel    2/22
  # Prints all basic position information from every page possible
  # Restores: @page
  def print_all_position_info
    initial_page = @page
    print_position_info
    while link = next_page
      @page = link.click
      print_position_info
    end
    # restores page to initial page
    @page = initial_page
  end

  private
  # Author Sunny Patel    2/22
  # Prints the position title and its salary for all positions
  def print_title_and_salary
    search_for_selectors('//h3 | //td[(((count(preceding-sibling::*) + 1) = 6) and parent::*)]', 2)
  end

  # Author Sunny Patel    2/22
  # Print all info related to a position
  def print_position_info
    search_for_selectors('//*[(@id = "search_results")]//tr[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]//td',6)
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

jobSite.search('senior')
jobSite.print_all_position_info
