module SearchHelper
	def search_song(song)
		search_base = "https://api.genius.com/search?q="
		# uri = URI("#{search_base}#{song}")
		# p uri
		# req = Net::HTTP::Get.new(uri)
		# req['Authorization'] = "Bearer #{ENV["GENIUS_ACCESS_TOKEN"]}"
		# p ENV["GENIUS_ACCESS_TOKEN"]

		# res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
		# p res

		open("#{search_base}#{song}", 'Authorization' => "Bearer #{ENV["GENIUS_ACCESS_TOKEN"]}").read
	end

	def grab_5_songs(json)
		hashed = JSON.parse(json)
		title_ids = hashed["response"]["hits"][0...5].map do |hit|
			{ hit["result"]["id"] => hit["result"]["full_title"] }
		end
		p title_ids
	end


end

helpers SearchHelper