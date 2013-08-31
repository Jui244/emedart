class HomeController < ApplicationController
	def index

	end
	def search
		params[:keywords]

		
		fakeData = [SearchResult.new("Marlborough", 300)]
		
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