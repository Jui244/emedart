class HomeController < ApplicationController
	def index

	end
	def search()
		params[:keywords]
		render json: @fakeData
	end
end 