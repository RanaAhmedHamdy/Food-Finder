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
end