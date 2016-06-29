require_relative 'utils'
require_relative 'restaurant'

class Guide

	class Config
		@@actions = ['quit', 'add', 'list', 'find']

		def self.actions
			@@actions
		end
	end

	def initialize(path=nil)
		Utils.filepath = path

		if Utils.file_exists?
			puts "Found"
		elsif Utils.create_file
			puts "created"
		else
			puts"Exit"
			exit!		
		end
	end

	def launch!
		introduction
		
		result = nil
		while result == nil
			puts "Available options : " + Guide::Config.actions.join(', ')
			print ">"
			order = gets.chomp.downcase.strip
			result = do_action(order)
		end

		conclusion
	end

	def do_action(order)
		case order
		when 'list'
			puts "Listing..."
		when 'find'
			puts "Finding..."
		when 'add'
			puts "Adding..."
			add
		when 'quit'
			return :quit
		else
			puts "I don't understand command\n"
		end
	end

	def add
		print "Restaurant name: "
		name = gets.chomp.strip
		
		print "Cusine: "
		cuisine = gets.chomp.strip
		
		print "Average Price: "
		average_price = gets.chomp.strip
		
		restaurant = Restaurant.new(name, cuisine, average_price)

		if Utils.write_in_file("#{[restaurant.name, restaurant.cuisine, restaurant.average_price].join("\t")}")
			puts "Added\n\n"
		else
			puts "Failed\n\n"
		end
	end

	def introduction
		puts "This is an app that helps you find best restaurants!"
	end

	def conclusion
		puts "GoodBye!"
	end
end