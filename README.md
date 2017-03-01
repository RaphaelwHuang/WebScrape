# Project 3
### Web Scraping

### Program Execution
In order to run the code, first run the command "bundle install" in the command line to install the Ruby gems necessary for the project in the gemfile.  Then type "ruby output.rb" to run the main function, which will prompt you for search input and an email address to get the results sent to.  To view the results of the scrape, open the folder the project is contained is, and open the file results.html in a web browser, which will display the results of the scrape.  Also, if you inputted an email, check your email to see the results there as well!

### Roles
* Overall Project Manager: Jennifer Alarcon
* Coding Manager: Raphael Huang
* Testing Manager: Sunny Patel
* Documentation: Kenton Steiner

### Contributions

Sunny Patel: Created the scraper class, which uses mechanize to scrape data from the website www.jobsatosu.com, and allows for the search options on the page to be utilized.  Data scraped from the website is stored in an array of arrays. Major bug fixing with email output; minor bug fixing with overall output.

Kenton Steiner: wrote the email function, which asks the user if they want the results emailed to them, and attaches the HTML webpage of the results of their search to the email.  Updated documentation and made sure the program was commented accordingly.  

Raphael Huang: Designed the HTML webpage and display function where the results of the search are outputted, after scraping the data from the jobs website by using Static Site Generation .erb to produce HTML webpage.  

Jenn Alarcon: Programming the main interface of the web scraping program, asks the user for input for the search fields, scrapes the website, and then returns the HTML webpage and emails the file to the specified email. 

Tony Su: Test cases for testing the crawl class, overall bug fixing. 

Kenton Steiner and Sunny Patel pair programmed the implementation of the search fields into the scraper class, so that more specialized searches could be performed, and added links to the job details page to the results. 

