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
  # NOT TESTED
  def fill_searchbar(query)
    form = get_form
    form['query'] = query
  end
end

jobSite = Scraper.new

jobSite.fill_searchbar('business')
jobSite.display_fields
