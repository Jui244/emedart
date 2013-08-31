require 'spec_helper'

describe HomeController do

	it "should return an array of SearchResults" do
		get :search
		response.should be_success
		response.body.count.should eq(3)
	end

end