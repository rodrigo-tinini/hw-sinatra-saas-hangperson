class HangpersonGame

   # add the necessary class methods, attributes, etc. here
   # to make the tests in spec/hangperson_game_spec.rb pass.
   
   # Get a word from remote "random word" service
   
   # def initialize()
   # end
  
   attr_accessor :word
   attr_accessor :guesses
   attr_accessor :wrong_guesses
  
  
  
   def initialize(word)
      @word = word
      @guesses = ""
      @wrong_guesses = ""
   end
   
   def self.get_random_word
       require 'uri'
       require 'net/http'
       uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
       Net::HTTP.post_form(uri ,{}).body
   end

   def guess(letter)
       
       if letter == ''
         raise ArgumentError, 'Can not be empty'
       end
       
       if letter == '%'
         raise ArgumentError, 'Can not be a symbol'
       end
       
       if letter.nil?
         raise ArgumentError, 'Can not be null'
       end
       
      letter.downcase!
      if @word.include? letter
         if !@guesses.include? letter
            @guesses << letter
            return true
         end
      else
         if !@wrong_guesses.include? letter
            @wrong_guesses << letter
            return true
         end
      end
      return false
   end

   def word_with_guesses
      guessed_word = ""
      @word.each_char do |char|
         if @guesses.include? char.downcase 
            guessed_word << char
         else 
            guessed_word << "-" 
         end
      end
      return guessed_word
   end
   
   def guess_several_letters letters
      letters each char do char
         guess char
      end
   end
   
   def check_win_or_lose
      if @wrong_guesses.length >= 7
         return :lose
      end
      if word_with_guesses == @word
         return :win
      end
      return :play
   end
end