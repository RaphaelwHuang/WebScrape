require 'mail'

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
yesno = gets.chomp.to_i
if yesno == 0 
 	puts "What email would you like your results sent to? "
 	user_email = gets
 	Mail.deliver do
 		to 	user_email
 		from 'Server <mail@gmail.com>'
 		subject 'OSU Job Search Results'
 		body ' '
 		add_file 'result.html'
	end

else 
	puts "No email will be sent!"
end
