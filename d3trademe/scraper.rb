require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
require 'json'
require 'net/http'
require 'sqlite3'

def generate(cat)
begin
	url = "http://api.trademe.co.nz/v1/Categories/#{cat}.json"
	result = JSON.parse(RestClient.get(url))
	db = SQLite3::Database.new "databaseTemp.db3"
    db.execute"DROP TABLE IF EXISTS Categories"
	db.execute"CREATE TABLE IF NOT EXISTS Categories(NAME STRING, NUMBER STRING PRIMARY KEY, PATH STRING)" 
	result["Subcategories"].each do |subcategory|
		db.execute "INSERT INTO Categories values (?, ?, ?)", [subcategory["Name"], subcategory["Number"], subcategory["Path"]]
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
    
    db = SQLite3::Database.new "database.db3"
    db.execute"DROP TABLE IF EXISTS Categories"
	db.execute"CREATE TABLE IF NOT EXISTS Categories(NAME STRING, NUMBER STRING PRIMARY KEY, PATH STRING)"  

	result["Subcategories"].each do |subcategory|
		db.execute "INSERT INTO Categories values (?, ?, ?)", [subcategory["Name"], subcategory["Number"], subcategory["Path"]]
	end

rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e  
    
ensure
    db.close if db
end

generate(1);






