require_relative 'utils'
require_relative 'restaurant'
require_relative 'restServices'

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
			RestServices.list
		when 'find'
			RestServices.find
		when 'add'
			puts "Adding..."
			RestServices.add
		when 'quit'
			return :quit
		else
			puts "I don't understand command\n"
		end
	end

	def introduction
		puts "This is an app that helps you find best restaurants!"
	end

	def conclusion
		puts "GoodBye!"
	end
end