module SpotifyHelper
	def get_search_results(word)
		unless word == "the"
			word = word.split("'").join("%27")
			p word
			search_base = "https://api.spotify.com/v1/search?q=#{word}&type=track"
			open(search_base).read 
		end
	end

	def return_a_track(json, word)
		return handle_the if word == "the"
		hashed = JSON.parse(json)
		tracks = hashed["tracks"]["items"]
		return return_not_found if tracks.length == 0
		chosen = tracks.sample
		while (tracks.length > 0) && (chosen["name"].split(" ").first.downcase != word)
			chosen = tracks.shift
			p "hi #{chosen["name"]} this is #{word}----------------------------------------" 
		end
		p "++++++++++++#{chosen["name"]} match #{word}"
		if chosen["name"].split(" ").first.downcase != word
			id = handle_common_words(word)
			return id ? id : return_not_found		
		end
		chosen["id"]
	end


	def return_not_found
		"2BY5fNHmpjV797ByjLX4I7"
	end

	def grab_all_results(lyrics)
		lyrics_set = lyrics.split.to_set
		p "***********************"
		p lyrics_set
		p "***********************"
		track_set = lyrics_set.map do |word|
			 { word => get_search_results(word) } 
		end
	end

	def handle_the
		["K4t31amVTZDgR3sKmwUJJ", "619A7U0RtsSEvqJeJdazJ3", "75JFxkI2RXiU7L9VXzMkle", "1Cj2vqUwlJVG27gJrun92y", "5OUSPcqhYTOzpbXzoEvKim"].sample
	end

	# def handle_a
	# 	["7lL3MvFWFFSD25pBz72Agj", "0ifooM33X1iBxVYyOkSbXW", "5sjIhQzNljMVrDklI91ezp", "1IGh7oA0ClbylSxrlbK8kK"]

	def handle_common_words(word)
		return handle_of if word == "of"
		return handle_and if word == "and"
		return handle_to if word == "to"
		nil
	end

	def handle_of
		["0gqfvyewE2Sh8TwKBFajCF", "7BNDyzwDboNRR2wmd7GSew", "26jrY21NkSefFPxpndtu4z"].sample
	end

	def handle_and
		["65vdMBskhx3akkG9vQlSH1", "3n5iUh2Z6P7cnWins22W0F", "35xAZwCzE58O6EXbzgTSxc", "1FCQEg7wOK9IIBuxx63krr"].sample
	end

	def handle_to
		["3AqPL1n1wKc5DVFFnYuJhp", "6w2VaBGWcColW05nZROWvS"].sample
	end

end

helpers SpotifyHelper