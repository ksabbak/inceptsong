module Parser
	def self.extract_web(website)
    Nokogiri::HTML(open(website))
  end

  def self.get_lyric_bit_from_genius(url)
  	whole_page = Parser.extract_web(url)

  	# "hi"
  	content = whole_page.css("head meta[name]").find do |meta|
  		meta.attributes["name"].value == "description"
  	end
  	content.attributes["content"].value
  end

  def self.get_words_out(text)
  	text.delete! ("/.,!?\"")
  	words = text.split(" ")
  	start = 0
  	words.each_with_index do |word, index|
  		if word == "Lyrics:"
  			start = index + 1
  		end
  	end
  	words = words[start..-1]
  	words.delete_if { |word| word[0] == "[" }
  	words.join(" ")
  end
end

