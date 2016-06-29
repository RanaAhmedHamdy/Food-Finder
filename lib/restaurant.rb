class Restaurant
	attr_accessor :name, :cuisine, :average_price

	def initialize(name, cuisine, average_price)
		@name = name
		@cuisine = cuisine
		@average_price = average_price
	end
end