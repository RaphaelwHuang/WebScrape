# Project 3
### Web Scraping

### Program Execution
In order to run the code, first run the command "bundle install" in the command line to install the Ruby gems necessary
for the project in the gemfile.  Then type "ruby output.rb" to run the main function, which will prompt you for search
input and, optionally, an email address which will contain an .html file with the results (job postings related to
input).  To view the results, open the directory of the project, open results.html in a web browser.  If a valid email
was provided, check it's inbox for the same file that is created in the project directory.

For the program that request meeting with the university president, simply type "ruby filler.rb" and the program will
prompt you to enter the necessary information for the form. You will see a output string that starts with "Thank you",
which means you successfully submit your request form.

### Roles
* Overall Project Manager: Jennifer Alarcon
* Coding Manager: Raphael Huang
* Testing Manager: Sunny Patel
* Documentation: Kenton Steiner

### Contributions

Sunny Patel: Created the scraper class, which uses mechanize to scrape data from the website www.jobsatosu.com, and
 allows for the search options on the page to be utilized.  Data scraped from the website is stored in an array of
  arrays. Major bug fixing with email output; minor bug fixing with overall output.

Kenton Steiner: wrote the email function, which asks the user if they want the results emailed to them, and attaches
the HTML webpage of the results of their search to the email.  Updated documentation and made sure the program was
commented accordingly, overall code look through and modifying to make more terse. 

Raphael Huang: Designed the HTML webpage and display function where the results of the search are outputted, after
scraping the data from the jobs website by using Static Site Generation .erb to produce HTML webpage.  

Jenn Alarcon: Programming the main interface of the web scraping program, asks the user for input for the search
fields, scrapes the website, and then returns the HTML webpage and emails the file to the specified email. 

Tony Su: Test cases for testing the crawl class, overall bug fixing. Authored filler.rb which requested a meeting with
the university president, which helped the team understand Forms in mechanize; however, team agreed to scrape
jobsatosu.com instead.

Kenton Steiner and Sunny Patel pair programmed (and pair tested) the implementation of the search fields into the
scraper class, so that more specialized searches could be performed, and added links to the job details page to
the results. 

### Testing

scraper.rb: Tested the methods related to the search form by using the methods to fill out the form and using the
mechanize method, pp (which would pretty print the page), to make sure the form was properly filled out. Display_fields was tested in a similar manner,
where we made sure the fields displayed were the ones in the pretty print. search_for_selectors was tested by using the
"selector gadget" bookmark for firefox. With this "gadget" you can select the elements you want to display and it
outputs an x_path. This output was used as the parameter for search_for_selectors and then I printed the result,
making sure it was what I expected. get_position_links was tested by printing the links and comparing them to those
in the pretty print. get_position_info was tested by searching different things (both with the code and on the website)
and then printing the resulting array and comparing it with the website's search results.
