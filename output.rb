# Author: Raohael Huang   2/23

require 'erb'
require_relative 'crawl'
	# Author Raphael Huang    2/23
  	# Prints all information to HTML (need an array and everthing from crawl  need work) 
	def display(array)
	  erbFile = 'default.html.erb'
	  htmlFile = File.basename(erbFile, '.erb')
	  erbContent = File.read(erbFile);
	  @content = ""
	  for i in 0 .. array.length-1
		@content+=format("
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>", position, title, department, deadline, number, salary)
	  end

	  renderer = ERB.new(erbContent)
	  result = renderer.result()
	  File.open(htmlFile, 'w') do |f|
		f.write(result)
	  end
	end
display()

