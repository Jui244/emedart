require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'net/http'
require 'sqlite3'


def generate(cat)
begin
	db = SQLite3::Database.new "database.db3"

	url = "http://api.trademe.co.nz/v1/Categories/#{cat}.json"
	result = JSON.parse(RestClient.get(url))
    db.execute"DROP TABLE IF EXISTS temp_categories"
	db.execute"CREATE TABLE IF NOT EXISTS temp_categories( STRING, number STRING PRIMARY KEY, path STRING)" 
	result["Subcategories"].each do |subcategory|
		db.execute "INSERT INTO temp_categories values (?, ?, ?)", [subcategory["Name"], subcategory["Number"], subcategory["Path"]]
	end
rescue SQLite3::Exception => e 
    puts "Exception occured"
    puts e  
ensure
    db.close if db
end
end

url = 'http://api.trademe.co.nz/v1/Categories/0.json'

result = JSON.parse(RestClient.get(url))

begin
db = SQLite3::Database.open "database.db3"

    db.execute"DROP TABLE IF EXISTS categories"
	db.execute"CREATE TABLE IF NOT EXISTS categories(name STRING, number STRING PRIMARY KEY, path STRING)"  

	result["Subcategories"].each do |subcategory|
		db.execute "INSERT INTO categories values (?, ?, ?)", [subcategory["Name"], subcategory["Number"], subcategory["Path"]]
	end

rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e  
    
ensure
    db.close if db
end

generate(1);






