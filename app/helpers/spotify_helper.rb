module SpotifyHelper
	def get_search_results(word)
		return handle_the if word == "the"

		word = word.split("'").join("%27")
		p word
		search_base = "https://api.spotify.com/v1/search?q=#{word}&type=track"
		open(search_base).read 
	end

	def return_a_track(json, word)
		hashed = JSON.parse(json)
		tracks = hashed["tracks"]["items"]
		return return_not_found if tracks.length == 0
		chosen = tracks.sample
		while (tracks.length > 0) && (chosen["name"].split(" ").first.downcase != word.downcase)
			chosen = tracks.shift
			p "hi #{chosen["name"]} this is #{word}----------------------------------------" 
		end
		p "++++++++++++#{chosen["name"]} match #{word}"
		return return_not_found if chosen["name"].split(" ").first.downcase != word.downcase
		chosen["id"]
	end


	def return_not_found
		"2BY5fNHmpjV797ByjLX4I7"
	end

	def grab_all_results(lyrics)
		lyrics_set = lyrics.split.to_set
		track_set = lyrics_set.map do |word|
			 { word => get_search_results(word) } 
		end
	end

	def handle_the
		["K4t31amVTZDgR3sKmwUJJ", "619A7U0RtsSEvqJeJdazJ3", "75JFxkI2RXiU7L9VXzMkle", "1Cj2vqUwlJVG27gJrun92y", "5OUSPcqhYTOzpbXzoEvKim"].sample
	end

	# def handle_a
	# 	["7lL3MvFWFFSD25pBz72Agj", "0ifooM33X1iBxVYyOkSbXW", "5sjIhQzNljMVrDklI91ezp", "1IGh7oA0ClbylSxrlbK8kK"]
end

helpers SpotifyHelper