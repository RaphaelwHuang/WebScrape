	# Author: Raohael Huang/ Jennifer Alarcon  2/23

	require 'erb'
	require_relative 'scraper'
	require 'mail'

	# Regular Expression for validating an email
	VALIDATE_EMAIL = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
	# Author Raphael Huang, Jennifer Alarcon    2/23
	# Prints all information to HTML (need an array and everything from crawl  need work)
  # Modifications:
  # Sunny Patel 2/28 - Cleaned up code to match style guides. call to email_user moved
	def display(array)
		erb_file = 'default.html.erb'
		html_file = File.basename erb_file, '.erb'
		erb_content = File.read erb_file 


		#Intialize the values of the search fileds to array positions
		position = array[0]
		title = array[1]
		department = array[2]
		deadline = array[3]
		number = array[4]
		salary = array[5]
		link = array[6]

		# Row format of the HTML table on the output webpage
		@content +=format("
		<tr><td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td>%s</td>
		<td><a href= %s >%s</a></td></tr>", position, title, department, deadline, number, salary, link, link)

		renderer = ERB.new erb_content
		result = renderer.result

		#Change the outoput file name
		File.open("result.html", 'w') {|f|	f.write result}
	end



	#Jennifer Alarcon 2/27
	#Get user input for email daily sign ups for job content
	def get_input(crawl)

		clear_screen
		# Get User input for Position Info field
		 if (position_keyword = get_pos_info) != ""
		 	crawl.search position_keyword
		 end
		clear_screen

		
		#Job posted within search field options
		if(within = get_posted_within) != ""
			#Input can only be a digit between 1-3
			while /^[1-3]$/.match(within) == nil && within != ""
				clear_screen
				puts "\t\t⚠ Invalid Entry. ⚠ Please Try Again! \n\n"
				within = get_posted_within
			end
			crawl.posted_within within if within != ""

		end
		clear_screen

		#Allow user to choose job location
		if (location_val = get_location_info) != ""
			#Input must be a number between 1 and 11
			while /^([1-9]|10|11)$/.match(location_val) == nil && location_val != ""
				clear_screen
				puts "\t\t\⚠ Invalid Entry. ⚠ Please Try Again! \n\n"
				location_val = get_location_info
			end

			crawl.location location_val if location_val != ""
		end
		clear_screen

		#Allow user to input a specific University title
		if (u_title = get_unviversity_title) != ""
				crawl.university_title u_title
		end
		clear_screen

		#Allow user to pick a specific job category
		if(job_cat = get_job_input) != ""
			#Input must be a digit between 3 and 6
			while /^[3-6]$/.match(job_cat) == nil && job_cat != ""
				clear_screen
				puts "\t\t⚠ Invalid Entry.⚠ Please Try Again! \n\n"
				job_cat = get_job_input
			end
			crawl.job_category job_cat if job_cat != ""
		end 
		clear_screen

		#Allow user to input specific working title for a job
		if(working_titleVal = get_working_title) != ""
			crawl.working_title working_titleVal 
		end
		clear_screen

		#Allow user to input a specific job opening number
		if(job_open_num = get_job_opening) != ""
			#Input can only contain numbers
			while /^\d+$/.match(job_open_num) == nil && job_open_num != ""
				clear_screen
				puts "\t\t⚠ Invalid Entry.⚠ Please Try Again! \n\n"
				job_open_num = get_job_opening
			end

			crawl.job_opening_number job_open_num if job_open_num != ""
		end
		clear_screen


		#Allow user to pick the type of the job
		if(job_type = get_job_type) != ""
			# Must be between 4-7
			while /^[4-7]$/.match(job_type) == nil && job_type != ""
				clear_screen
				puts "\t\t⚠ Invalid Entry.⚠ Please Try Again! \n\n"
				job_type = get_job_type
			end
			crawl.job_time job_type if job_type != ""
		end
		clear_screen

		end

	#Jennifer Alarcon 2/27
	#Clears the screen for the next input prompt
	def clear_screen
		system "clear"
	end


	#Jennifer Alarcon 2/27

	#Ask user to enter information for the Keywords: search field on the website
	#Returns input
	def get_pos_info
		puts "Enter the keywords for postion or press enter if nothing to enter: "
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to select a time period in the posted Within search field
	#Returns input
	def get_posted_within
		puts "Enter number corresponding to jobs posted within designated time or press enter if nothing to input: "
		puts "\n\t1 = Last Day\n\t2 = Last Week\n\t3 = Last Month\n\nPosted within number:"
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to pick a location from the Location search field
	#Returns input
	def get_location_info
		puts "Enter number corresponding to location or press enter if nothing to input: "
		puts "\n\t1 = Columbus\n\t2 = Lima\n\t3 = Mansfield\n\t4 = Marion\n\t5 = Newark\n\t6 = Wooster\n\t8 = Delaware\n\t9 = Springfield\n\t10 = Piketon\n\t11 = Dayton\n\nLocation number:"
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to enter terms in the University Title search field
	#Returns input
	def get_unviversity_title
		puts "Enter university title or press enter if nothing to input: "
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to select an option from the Job Category Search field
	#Returns input
	def get_job_input
		puts "Enter number corresponding to Job Category or press enter if nothing to input: "
		puts "\n\t2 = instructional/faculty\n\t3 = adminstrative and professional\n\t4 = information technology\n\t5 = research\n\t6 = civil service\n\nJob category number:"
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to input terms to the Working Title search field
	#Returns input
	def get_working_title
		puts "Enter  working title or press enter if nothing to input: "
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to input a specific job number in the Job Opening Number search field
	#Returns input
	def get_job_opening
		puts "Enter job opening number or press enter if nothing to input: "
		gets.chomp!
	end

	#Jennifer Alarcon 2/27
	#Allows user to pick a specific type of job from the Full/Part Time search field
	#Returns input
	def get_job_type
		puts "Enter number corresponding to position type or press enter if nothing to input: "
		puts "\n\t4 = full time\n\t5 = part time\n\t6 = temporary\n\t7 = term\n\nPosition type number:"
		gets.chomp!
	end




	#Kenton Steiner 2/23
	#Allows user to get an email with an attachment of the results of the search
	#Modifications: 
	#Jennifer Alarcon - fixed yes/no option for user, proovie validation checking 
	#Kenton Steiner - 2/28 - Added comments, updated the body and From fields of the resulting email
	#Kenton Steiner - 3/2 - Added regular expression to validate the email entered by the user
	def email_user
		# Intialization of the sending server of the email
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

		# Ask if the user would like to receive an email of the results
		puts "Would you like the results emailed to you? (0 for yes, 1 for no) "
		yesno = gets.chomp

		#Validate the entry for yes or no  
		while /^[0-1]$/.match(yesno) == nil
			puts "\nInvalid option! Try again!"
			puts "Would you like the results emailed to you? (0 for yes, 1 for no) "
			yesno = gets.chomp
			clear_screen
		end

		yesno = yesno.to_i
		# If the user entered a 0, ask them for thei email they want it sent to.
		if yesno == 0 
			# Ask the user for their email
	 		puts "What email would you like your results sent to? "
	 		user_email = gets.chomp
	 		# Check the input with the regular expression for validating an email address
	 		while VALIDATE_EMAIL.match(user_email) == nil && user_email != ""
				clear_screen
				puts "\t\t⚠ Invalid Entry.⚠ Please Try Again! \n\n"
				user_email = gets.chomp
			end
	 		
	 		#send the email to the user email from the server initialized
		 	Mail.deliver do
		 		to 	user_email
		 		from 'Job Search Server <mail@gmail.com>'
		 		subject 'OSU Job Search Results'
		 		body 'Please see the attachment for the results of your job search!'
		 		add_file 'result.html'
			end
			puts "Sending email...\n"
		else 
			puts "No email will be sent! :("
		end

		end




	#Jennifer Alarcon - 2/27
	#Returns input
  # Modifications:
  # Sunny Patel 2/28- Email now sends the appropriate file
	def main
		crawl = Scraper.new
		get_input crawl
		# submit form
		crawl.submit_form

		#Get array of all jobs
		super_array= crawl.get_position_info

		@content = ""
		super_array.each do |sub_array|
		#display array for single job listing
	      	display(sub_array)
    end

    # Email user if they wish to be emailed
    email_user
    puts "Thanks for filling out the information! Goodbye! :-)"

	end

	main
