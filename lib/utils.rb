require_relative 'restaurant'

class Utils
	@@filepath = nil

	def self.filepath=(path=nil)
		@@filepath = File.join(File.dirname(__FILE__), 'restaurants.txt')
	end

	def self.file_exists?
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	def self.create_file
		File.open(@@filepath, 'w')
	end

	def self.write_in_file(line)
		File.open(@@filepath, 'a') do |file|
			file.puts line + "\n"
		end 
		return true
	end

	def self.read_file
		output = []
		f = File.new(@@filepath, 'r').each_line do |line|
			restaurant = self.import_line(line.chomp)
			output << restaurant
		end 
		f.close

		return output
	end

	def self.import_line(line)
		line_split = line.split("\t")
		return Restaurant.new(line_split[0], line_split[1], line_split[2])
	end
end