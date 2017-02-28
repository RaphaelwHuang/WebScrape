# Author: Raohael Huang/ Jennifer Alarcon  2/23

require 'erb'
require_relative 'crawl'


# Author Raphael Huang, Jennifer Alarcon    2/23
# Prints all information to HTML (need an array and everthing from crawl  need work)
def display(array)
	erbFile = 'default.html.erb'
	htmlFile = File.basename(erbFile, '.erb')
	erbContent = File.read(erbFile);


	#All the values
	position  = array[0];
	title 	= array[1];
	department = array[2];
	deadline 	= array[3];
	number 	= array[4];
	salary 	= array[5];
	link 		= array[6];


	array.each do |i|
		@content =format("
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>", position, title, department, deadline, number, salary, link)
	end

	renderer = ERB.new(erbContent)
	result = renderer.result()
	File.open(htmlFile, 'w') do |f|
		f.write(result)
	end
end



#Jennifer Alarcon
#Get user input for email daily sign ups for job content
def getInput(crawl)

	clearScreen

	#GET POSITION INFO
	if (position_keyword = getPosInfo) != ""
		#******need to validiate 
		crawl.search position_keyword
	end
	clearScreen

	
	#GET POSTED WITHIN
	if(within = getPostedWithin) != ""
		#******need to validiate 
		crawl.posted_within within
	end
	clearScreen

	#GET LOCATION INFO
	if (locationVal = getLocationInfo) != ""
		#******need to validiate 
		crawl.location locationVal
	end
	clearScreen

	#GET UNIVERISTY TITLE
	if (u_titleVal = getUnviversitytitle) != ""
		#******need to validiate 
		crawl.univeristy_title u_titleVal
	end
	clearScreen

	#GET JOB CATEGORY INPUT
	if(job_catVal = getJobInput) != ""
		#******need to validiate 
		crawl.job_category job_catVal
	end 
	clearScreen

	#GET WORKING TITLE
	if(working_titleVal = getWorkingTitle) != ""
		#**need to validiate 
		crawl.working_title working_titleVal
	end
	clearScreen

	#GET JOB OPENING NUMBER
	if(jobopen_num = getJobOpening) != ""
		#**need to validate 
		crawl.jobopen_number jobopen_num

	end
	clearScreen


	#GET JOB TYPE
	if(job_type = getJobType) != ""
		#**need to validate 
		crawl.job_time job_type
	end
	clearScreen

	
	puts "Thanks for filling out the information!"

	end


#Jennifer Alarcon
#Checks to see if user entered appropriate location
#use regEx
def validiateLocation
	return true
end

def clearScreen
	system "clear"
end


#Jennifer Alarcon
#GET POSITION INFO
#Returns input
def getPosInfo
	puts "Enter the keywords for postion or press enter if nothing to enter: "
	position_keyword = gets.chomp!
end

#Jennifer Alarcon
#GET POSTED WITHIN
#Returns input
def getPostedWithin
	puts "Enter number corresponding to jobs post within designated time or press enter if nothing to input: "
	puts "Posted within:\n\t1 = Last Day\n\t2 = Last Week\n\t3 = Last Month"
	post_within = gets.chomp!
end

#Jennifer Alarcon
#GET LOCATION INFO
#Returns input
def getLocationInfo
	puts "Enter number corresponding to location or press enter if nothing to input: "
	puts "\t1 = Columbus\n\t2 = Lima\n\t3 = Mansfield\n\t4 = Marion\n\t5 = Newark\n\t6 = Wooster\n\t8 = Delaware\n\t9 = Springfield\n\t10 = Piketon\n\t11 = Dayton"
	location = gets.chomp!
end

#Jennifer Alarcon
#GET UNIVERISTY TITLE
#Returns input
def getUnviversitytitle
	puts "Enter number corresponding to location or press enter if nothing to input: "
	univeristy_title = gets.chomp!
end

#Jennifer Alarcon
#GET JOB CATEGORY INPUT
#Returns input
def getJobInput
	puts "Enter number corresponding to Job Category or press enter if nothing to input: "
	puts "Enter the location number: 2 = instructional/faculty\n\t3 = adminstrative and professional\n\t4 = information technology\n\t5 = research\n\t6 = civil service"
	location = gets.chomp!
end

#Jennifer Alarcon
#GET WORKING TITLE
#Returns input
def getWorkingTitle
	puts "Enter  working title or press enter if nothing to input: "
	working_title = gets.chomp!
end

#Jennifer Alarcon
#GET JOB OPENING NUMBER
#Returns input
def getJobOpening
	puts "Enter job opening number or press enter if nothing to input: "
	jobopen_number = gets.chomp!
end

#Jennifer Alarcon
#GET JOB TYPE
#Returns input
def getJobType
	puts "Enter number corresponding to position type or press enter if nothing to input: "
	puts "\t4 = full time\n\t5 = part time\n\t6 = temporary\n\t7 = term"
	job_type = gets.chomp!
end

#Jennifer Alarcon
#GET EMAIL 
#Returns input
def getEmail
	puts "Please enter your email so we can send you information on jobs you are interested in! :-) or press enter if you don't want to have this information for future reference. :("
	email = gets.chomp!
end


#Jennifer Alarcon
#Returns input
def main
	crawl = Scraper.new
	getInput crawl
	#submit form 
	crawl.submit_form

	#Get array of all jobs
	super_array= crawl.get_position_info
	crawl.print_info_array(super_array)
	super_array.each do |sub_array|
		#display array for single job listing
      display(sub_array)
    end

end

main
