require 'mechanize'
require 'nokogiri'

# Author: Sunny Patel   2/21
class Meeting
  @@url = 'http://president.osu.edu/contact/meeting-request.html'
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
  
end

