require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'net/http'
require 'sqlite3'


class Scraper
	def self.generate(cat)
		url = "http://api.trademe.co.nz/v1/Categories/#{cat}.json?depth=1"
		result = JSON.parse(RestClient.get(url))

		result["Subcategories"].collect do |subcategory|
			Subcategory.new(subcategory["Number"], subcategory["Name"])
		end
	end

	def self.initialise

		url = 'http://api.trademe.co.nz/v1/Categories/0.json'

		result = JSON.parse(RestClient.get(url))

		result["Subcategories"].each_with_index do |subcategory, index|
			Category.create(:name => subcategory["Name"], :number => subcategory["Number"], :path => subcategory["Path"])
		end

	end
end


