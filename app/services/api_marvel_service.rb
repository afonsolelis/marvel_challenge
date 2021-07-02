class ApiMarvelService
	attr_accessor :public_key, :private_key
	include HTTParty
  	base_uri 'gateway.marvel.com/v1/public'

	def initializer
		@public_key = "2e1337f9b516f468a9cc687dbc164e4c"
		@private_key = "b60f6a962bff44e0164431c7dd96c462b2b8cae7"
	end

	def import_characters(page = 0)
		response = get_50_char_per_page(page)
		response["data"]["results"].each do |character|
			Character.create_with(
				name: character["name"],
				description: character["description"],
				thumbnail: character["thumbnail"]["path"]+"."+character["thumbnail"]["extension"]
				).find_or_create_by(
					char_id: character["id"]
				)

		 end
		 pages = (response["data"]["total"] / 100).ceil
		 if page <= pages
		 	import_characters(page + 1)
		 end
	end

	def get_50_char_per_page(page = 0)
		offset = page * 100
		self.class.get("/characters?limit=100&offset=#{offset}&ts=1&apikey=2e1337f9b516f468a9cc687dbc164e4c&hash=#{hash_generator}")	
	end

	private
	def hash_generator
		Digest::MD5.hexdigest "1b60f6a962bff44e0164431c7dd96c462b2b8cae72e1337f9b516f468a9cc687dbc164e4c"
	end
end