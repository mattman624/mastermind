def substrings(phrase, dictionary)
	frequencies = Hash.new(0)
	words = phrase.downcase.split(" ")
	words.each do |word|
		dictionary.each do |substring|
			if word[substring]
				frequencies[substring] += 1 #frequencies[word] + 1
			end
		end
	end
	
	frequencies

end
