class Api::CharactersController < ApplicationController

	def index
		service = ApiMarvelService.new
		char_list = service.import_characters
		render json: Character.all
	end
end
