	# Author: Raohael Huang/ Jennifer Alarcon  2/23

	require 'erb'
	require_relative 'crawl'
	require 'mail'



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
			crawl.search position_keyword
		end
		clearScreen

		
		#GET POSTED WITHIN
		if(within = getPostedWithin) != ""
			#can only be 1 2 3
			while /^(1|2|3)$/.match(within) == nil && within != ""
				clearScreen
				puts "⚠ Invalid Entry. ⚠ Please Try Again! "
				within = getPostedWithin
			end
			if within != "" 
				crawl.posted_within within
			end

		end
		clearScreen

		#GET LOCATION INFO
		if (locationVal = getLocationInfo) != ""
			#1 -11
			while /^([1-9]|10|11)$/.match(locationVal) == nil && locationVal != ""
				clearScreen
				puts "⚠ Invalid Entry. ⚠ Please Try Again! "
				locationVal = getLocationInfo
			end

			if within != "" 
				crawl.location locationVal
			end
		end
		clearScreen

		#GET UNIVERISTY TITLE
		if (u_titleVal = getUnviversitytitle) != ""
			crawl.university_title u_titleVal
		end
		clearScreen

		#GET JOB CATEGORY INPUT
		if(job_catVal = getJobInput) != ""
			#3456
			while /^[3-6]$/.match(job_catVal) == nil && job_catVal != ""
				clearScreen
				puts "⚠ Invalid Entry.⚠ Please Try Again! "
				job_catVal = getJobInput
			end
			if within != "" 
				crawl.job_category job_catVal
			end
		end 
		clearScreen

		#GET WORKING TITLE
		if(working_titleVal = getWorkingTitle) != ""
			crawl.working_title working_titleVal
		end
		clearScreen

		#GET JOB OPENING NUMBER
		if(jobopen_num = getJobOpening) != ""
			#only numbers
			while /^[\d]+$/.match(jobopen_num) == nil && jobopen_num != ""
				clearScreen
				puts "⚠ Invalid Entry.⚠ Please Try Again! "
				jobopen_num = getJobOpening
			end

			if within != "" 
				crawl.job_opening_number jobopen_num
			end

		end
		clearScreen


		#GET JOB TYPE
		if(job_type = getJobType) != ""
			#4-7
			while /^[4-7]$/.match(job_type) == nil && job_type != ""
				clearScreen
				puts "⚠ Invalid Entry.⚠ Please Try Again! "
				job_type = getJobType
			end
			crawl.job_time job_type
		end
		clearScreen

		#GET EMAIL 
		emailUser


		puts "Thanks for filling out the information! Goodbye! :-)"

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
		puts "\n\t1 = Columbus\n\t2 = Lima\n\t3 = Mansfield\n\t4 = Marion\n\t5 = Newark\n\t6 = Wooster\n\t8 = Delaware\n\t9 = Springfield\n\t10 = Piketon\n\t11 = Dayton"
		location = gets.chomp!
	end

	#Jennifer Alarcon
	#GET UNIVERISTY TITLE
	#Returns input
	def getUnviversitytitle
		puts "Enter unviersity title or press enter if nothing to input: "
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




	#Kenton Steiner
	#email user the information 
	#Modifications: 
		#Jennifer Alarcon - fixed yes/no option for user, proovie validation checking 

	def emailUser()
		options = { :address          => "smtp.gmail.com",
	        :port                 => 587,
	        :domain               => 'gmail.com',
	        :user_name            => 'cse3901project@gmail.com',
	        :password             => 'ineedthistosendemail',
	        :authentication       => 'plain',
	        :enable_starttls_auto => true  
	 }

		Mail.defaults do 
		 delivery_method :smtp, options
		end

		yesno = 0
		puts "Would you like the results emailed to you? (0 for yes, 1 for no) "
		yesno = gets.chomp

		#Validate entry 
		while /^[0-1]$/.match(yesno) == nil
			puts "\nInvalid selection! Try again!"
			puts "Would you like the results emailed to you? (0 for yes, 1 for no) "
			yesno = gets.chomp
		end

		yesno = yesno.to_i

		if yesno == 0 
	 		puts "What email would you like your results sent to? "
	 		user_email = gets

		 	Mail.deliver do
		 		to 	user_email
		 		from 'Server <mail@gmail.com>'
		 		subject 'OSU Job Search Results'
		 		body ' '
		 		add_file 'default.html'
			end
			puts "Sending email...\n"
		else 
			puts "No email will be sent! :("
		end

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
		#crawl.print_info_array(super_array) #testing purposes 
		super_array.each do |sub_array|
			#display array for single job listing
	      display(sub_array)
	    end

	end

	main
