class Api::CharactersController < ApplicationController
	before_action :authenticate_api_user!
	def index
		# service = ApiMarvelService.new
		# char_list = service.import_characters
		render json: Character.all
	end
end
