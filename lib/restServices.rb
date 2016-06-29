class RestServices
	def self.add
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

	def self.list
		restaurants = Utils.read_file
		output_restaurants_table(restaurants)
	end

	def self.output_restaurants_table(restaurants)
		restaurants.each do |r|
			puts "#{r.name}\t#{r.cuisine}\t#{r.average_price}"
		end
	end

	def self.find
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

end