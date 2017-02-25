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
	def getInput

		
		
		clearScreen
		#GET POSITION INFO
		puts "Enter the keywords for postion or press enter if nothing to enter: "
		position_keyword = gets.chomp!
		clearScreen

		#GET POSTED WITHIN
		puts "Enter number corresponding to jobs post within designated time or press enter if nothing to input: "
		puts "Posted within:\n\t1 = Last Day\n\t2 = Last Week\n\t3 = Last Month"
		post_within = gets.chomp!
		clearScreen

		#GET LOCATION INFO
		puts "Enter number corresponding to location or press enter if nothing to input: "
		puts "\t1 = Columbus\n\t2 = Lima\n\t3 = Mansfield\n\t4 = Marion\n\t5 = Newark\n\t6 = Wooster\n\t8 = Delaware\n\t9 = Springfield\n\t10 = Piketon\n\t1 = Dayton"
		location = gets.chomp!
		#validate user input 
		clearScreen

		#GET UNIVERISTY TITLE
		puts "Enter number corresponding to location or press enter if nothing to input: "
		univeristy_title = gets.chomp!
		clearScreen

		#GET JOB CATEGORY INPUT
		puts "Enter number corresponding to Job Category or press enter if nothing to input: "
		puts "Enter the location number: 2 = instructional/faculty\n\t3 = adminstrative and professional\n\t4 = information technology\n\t5 = research\n\t6 = civil service"
		location = gets.chomp!
		clearScreen

		#GET WORKING TITLE
		puts "Enter  working title or press enter if nothing to input: "
		working_title = gets.chomp!
		clearScreen

		#GET JOB OPENING NUMBER
		puts "Enter job opening number or press enter if nothing to input: "
		jobopen_number = gets.chomp!
		clearScreen


		#GET JOB TYPE
		puts "Enter number corresponding to position type or press enter if nothing to input: "
		puts "\t4 = full time\n\t5 = part time\n\t6 = temporary\n\t7 = term"
		job_type = gets.chomp!
		clearScreen


		puts "Please enter your email so we can send you information on jobs you are interested in! :-) or press enter if you don't want to have this information for future reference. :("
		email = gets.chomp!
	
		requestedInfo =[position_keyword, post_within, location, univeristy_title, location, working_title, jobopen_number, job_type]
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
	#Checks to see if user entered approtiate location 
	#use regEx
	def validiateLocation
		return true
	end

	



	def test
		
		
	end

	def main
		getInput
	end

	main

	



