class Subcategory 
	include ActiveModel::Conversion

	attr_accessor :name, :id

	def initialize(id, name)
		@id = id
		@name = name
	end

	def persisted?
		false
	end
end