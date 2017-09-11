get '/' do 
	if ( song = params[:songid] )
		p song
		first = Parser.get_lyric_bit_from_genius("https://genius.com/songs/#{song}")
		@lyrics = Parser.get_words_out(first)
		p "++++++++++++++++++"
		p @lyrics
		p "++++++++++++++++++"
		tracks = grab_all_results(@lyrics).to_a


		@ids = @lyrics.split.map do |word|
			track = tracks.find { |track| track.keys[0] == word}
			return_a_track(track.values[0], word)
		end
	end
	
	erb :'/index'
end

post '/' do 

	gross = search_song(params[:search][:text])
	@song_options = grab_5_songs(gross)

	erb :'/index'
end
