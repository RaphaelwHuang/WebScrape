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

  # Author Sunny Patel    2/21
  # Only selects selector expressions
  # Will print the text of all selectors that match search
  def search_for_selectors(search)
    @page.search(search).each {|selector| puts selector.text.strip}
  end

  # Author Sunny Patel    2/21
  # Prints the position title and its salary for all positions
  def print_title_and_salary
    search_for_selectors '//h3 | //td[(((count(preceding-sibling::*) + 1) = 6) and parent::*)]'
  end

  # Author Sunny Patel    2/21
  # Will pretty print the page
  def pretty_print_page
    pp @page
  end
end

jobSite = Scraper.new

jobSite.fill_searchbar('business')
jobSite.display_fields
# Tell team about selector gadget.
jobSite.print_title_and_salary