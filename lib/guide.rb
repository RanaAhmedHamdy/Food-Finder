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
		while result != :quit
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
			list
		when 'find'
			find
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

	def list
		restaurants = Utils.read_file
		output_restaurants_table(restaurants)
	end

	def output_restaurants_table(restaurants)
		restaurants.each do |r|
			puts "#{r.name}\t#{r.cuisine}\t#{r.average_price}"
		end
	end

	def find
		print "Enter Keyword: "
		keyword = gets.chomp.strip
		restaurants = Utils.read_file

		if keyword
			found = restaurants.select do |rest|
				rest.name.downcase.include?(keyword.downcase) || rest.cuisine.downcase.include?(keyword.downcase) || rest.average_price.to_i <= keyword.to_i
			end
			output_restaurants_table(found)
		else
			Puts "Enter a keyword"
		end
	end

	def introduction
		puts "This is an app that helps you find best restaurants!"
	end

	def conclusion
		puts "GoodBye!"
	end
end