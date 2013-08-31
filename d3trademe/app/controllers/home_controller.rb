class HomeController < ApplicationController
	def index

	end
	def search
		params[:keywords]

		
		fakeData = [SearchResult.new("Marlborough", 300),
			SearchResult.new("Wellington", 1000),
			SearchResult.new("Auckland", 1700),
			SearchResult.new("Waikato", 400),
			SearchResult.new("Gisborne", 150),
			SearchResult.new("Otago",678 ),
			SearchResult.new("Taranaki", 70),
			SearchResult.new("Wairarapa", 50),
			SearchResult.new("Nelson Bays", 300),
			SearchResult.new("Hawke's Bay", 60),
			SearchResult.new("Wanganui", 30),
			SearchResult.new("West Coast", 600),
			SearchResult.new("Canterbury", 60),

		]
		
		render json: fakeData
	end
end 

class SearchResult 
	attr_accessor :region, :count

	def initialize(region, count)
		@region = region
		@count = count
	end
end