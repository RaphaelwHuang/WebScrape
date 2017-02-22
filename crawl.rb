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

  # Author: Sunny Patel   2/21
  def get_form
    @page.forms.first
  end

  # Author Sunny Patel    2/21
  # Fills in the searchbar on the main posting page
  def fill_searchbar(query)
    form = get_form
    form['query'] = query
  end

  # Author Sunny Patel    2/22
  # Only selects selector expressions
  # Will print the text of all selectors that match search
  def search_for_selectors(search)
    @page.search(search).each {|selector| puts selector.text.strip}
  end

  # Author Sunny Patel    2/22
  # Prints the position title and its salary for all positions
  def print_title_and_salary
    search_for_selectors '//h3 | //td[(((count(preceding-sibling::*) + 1) = 6) and parent::*)]'
  end

  # Author Sunny Patel    2/22
  # Will pretty print the page
  def pretty_print_page
    pp @page
  end

  # Author Sunny Patel    2/22
  # RETURNS: the next page OR NIL if page does not exist
  def next_page
    @page.link_with(:text => /Next/)
  end

  # Author Sunny Patel    2/22
  # Prints titles and salaries from every page possible
  def print_all_titles_and_salaries
    print_title_and_salary
    while link = next_page
      @page = link.click
      print_title_and_salary
    end
  end

end



jobSite = Scraper.new
# Tell team about selector gadget.
jobSite.print_all_titles_and_salaries
