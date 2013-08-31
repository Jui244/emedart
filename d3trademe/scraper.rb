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
	return result[subcategories]
end


def init
url = 'http://api.trademe.co.nz/v1/Categories/0.json?depth=1'

result = JSON.parse(RestClient.get(url))

begin
db = SQLite3::Database.open "db/development.sqlite3"

    db.execute"DROP TABLE IF EXISTS categories"
	db.execute"CREATE TABLE IF NOT EXISTS categories(id INTEGER, name STRING, number STRING PRIMARY KEY, path STRING)"  

	result["Subcategories"].each_with_index do |subcategory, index|
		db.execute "INSERT INTO categories values (?, ?, ?, ?)", [index, subcategory["Name"], subcategory["Number"], subcategory["Path"]]
	end

rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e  
    
ensure
    db.close if db
end
end
generate(1);

end




