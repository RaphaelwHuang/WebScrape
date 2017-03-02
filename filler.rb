require 'rubygems'
require 'mechanize'

# Author: Tony Su   2/21
# Filler class will take user's input and fill the form.
class Filler
    @@url = 'http://president.osu.edu/contact/meeting-request.html'

    # Author:Tony Su   2/21
    def initialize
        @agent = Mechanize.new
        @page = @agent.get(@@url)
        @form = @page.forms.first
      end

    # Author: Tony Su   2/27
    # Displays all the fields for the first form
    def display_fields
        @form.fields.each {|f| puts f.name}
      end

    # Author Tony Su   2/27
    # Fills in field of contact_name
    def contact_name
        puts "Please enter your name:"
        name = gets.chomp!
        @form['contact-name']  = name
    end

    # Author Tony Su   2/27
    # Fills in field of contact_email,check if user enter a valid osu email
    def contact_email
        puts "Please enter your email:"
        email = gets.chomp!
        # check the format of the email address. The email address must be a osu email.
        until email =~ /[a-z][a-z]*\.[1-9]\d*@osu\.edu/
                 puts "Please enter a valid email address of osu, format should looks like su.342@osu.edu"
                 email = gets.chomp!
               end
        @form['contact-email']  = email
    end

    # Author Tony Su   2/27
    # Fills in field of contact_phone, check if user enter a valid phone address
    def contact_phone
        puts "Please enter your phone number:"
        phone = gets.chomp!
        # check the format of the phone number
        until phone =~ /\d{3}-\d{3}-\d{4}/
                 puts "Please enter your phone number as xxx-xxx-xxxx where x is a number"
                 phone = gets.chomp!
               end
        @form['contact-phone']  = phone
    end

   # Author Tony Su   2/27
   # Fills in field of contact_dept
    def contact_dept
        puts "Please enter your department/organization, you can leave it empty:"
        department = gets.chomp!
        @form['contact-dept']  = department
    end

   # Author Tony Su   2/27
   # Fills in field of contact_addr
    def contact_addr
        puts "Please enter your street address, you can leave it empty:"
        addr = gets.chomp!
        @form['contact-addr']  = addr
    end

    # Author Tony Su   2/27
    # Fills in field of contact_city
    def contact_city
        puts "Please enter the city, you can leave it empty:"
        city = gets.chomp!
        @form['contact-city']  = city
    end

    # Author Tony Su   2/27
    # Fills in field of contact_zipcode
    def contact_zipcode
        puts "Please enter the zipcode, you can leave it empty:"
        zip = gets.chomp!
        @form['contact-zipcode']  = zip
    end

    # Author Tony Su   2/27
    # Fills in field of contact_comment
    def contact_comment
        puts "Please enter a comment, you can leave it empty:"
        comment = gets.chomp!
        @form['contact-comments']  = comment
    end

    # Author Tony Su   2/27
    # Fills in field of meeting_name
    def meeting_name
        puts "Please enter the name of your meeeting, you can leave it empty:"
        a = gets.chomp!
        @form['meeting-name']  = a
    end

    # Author Tony Su   2/27
    # Fills in field of meeting_timeline
    def meeting_timeline
    puts "Please enter the timeline of your meeting, you can leave it empty:"
       a = gets.chomp!
      @form['meeting-timeline']  = a
    end

    # Author Tony Su   2/27
    # Fills in field of meeting_purpose
    def meeting_purpose
        puts "Please enter the purpose of your meeting, you can leave it empty:"
        a = gets.chomp!
        @form['meeting-purpose']  = a
    end

    # Author Tony Su   2/27
    # bypass the verification question. The method set the correct value to the field math.
    def bypass
        a = @form["op1"].to_i
        b = @form["op2"].to_i
        c = 0
        if @form["operator"].eql? "+"
                 c = a+b
        else
                  c = a-b
        end
        @form['math'] = c.to_s
      end

  # Author Tony Su    2/27
  # Submits form
   def submit
        @form.submit
      end

  end

# Create a new variable.
a = Filler.new()

# Call each method to ask user to enter necessary information.
a.contact_name
a.contact_email
a.contact_phone
a.contact_dept
a.contact_addr
a.contact_city
a.contact_zipcode
a.contact_comment
a.meeting_name
a.meeting_purpose
a.meeting_timeline

# bypass the verfication
a.bypass
new_page = a.submit
#print the title of the new page, if the title is "Thank You | Office of the President",
# it means the form has been submitted.
puts new_page.title