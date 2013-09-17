require 'oauth'

class HomeController < ApplicationController
	def search
		keywords = params[:keywords]
		cat = params[:cat]
		subCat =params[:subCat]
		
		if(!subCat.nil? && subCat != "Please choose")
			choice = subCat
		elsif(!cat.nil?)
			choice = cat
		else
			choice = "0"
		end
		#fix keywords
		url = "https://api.trademe.co.nz/v1/Search/General.json?category=#{choice}&search_string=#{keywords}&rows=501"
		#consumer = ::OAuth::Consumer.new(" ", " ", :site => "https://secure.trademe.co.nz")
		 # fill in OAuth keys above with your own keys. 
		token = ::OAuth::ConsumerToken.new(consumer, '2988879ACAA375E4D9734072AB0DB2D0B5', 'A45830807EC7D9C85AE80487B9E6BF8A7D')
		request = token.request(:get, url)
		regionsToCount = {}
		JSON.parse(request.body)["List"].each do |result|
			if regionsToCount[result["Region"]]
				regionsToCount[result["Region"]] += 1 
			else
				regionsToCount[result["Region"]] = 1
			end
		end
		results = regionsToCount.collect do |region, count|
			SearchResult.new(region, count)
		end
		render json: results
	end
	
	def subcategories
		if params[:category_id]
			@subcategories = Scraper.generate(params[:category_id])
		end
	end
end 


class SearchResult 
	attr_accessor :region, :count
	def initialize(region, count)
		@region = region
		@count = count
	end
end