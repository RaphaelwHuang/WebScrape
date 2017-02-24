# Project 3
### Web Scraping

### Roles
* Overall Project Manager: Jennifer Alarcon
* Coding Manager: Raphael Huang
* Testing Manager: Sunny Patel
* Documentation: Kenton Steiner

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.
Sunny Patel: Created the scraper class, which uses mechanize to scrape data from the website www.jobsatosu.com, and allows for the search options on the page to be utilized.  Data scraped from the website is stored in an array of arrays.

Kenton Steiner: wrote the email function, which asks the user if they want the results emailed to them, and attaches the HTML webpage of the results of their search to the email.

Raphael Huang: Designed the HTML webpage where the results of the search are outputted, after scraping the data from the jobs website.

Jenn Alarcon: Programming the main interface of the web scraping program, asks the user for input for the search fields, scrapes the website, and then returns the HTML webpage and emails the file to the specified email. 

Kenton Steiner and Sunny Patel pair programmed the implementation of the search fields into the scraper class, so that more specialized searches could be performed, and added links to the job details page to the results.  