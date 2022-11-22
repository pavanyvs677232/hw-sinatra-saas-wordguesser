class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :correct_guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
	@correct_guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

def guess(guess)
      invalid(guess)
      use = guess.downcase
      correct = false
      if @correct_guesses.include? use or @wrong_guesses.include? use
        return false
      end
      for i in 0...(@word.length)
          if @word[i] == use
            correct = true
          end
      end
      if !correct
        @wrong_guesses += use
      else
        @correct_guesses += use
      end
    
  end

  def word_with_guesses()
    save = ''
    for i in 0...(@word.length) do
      letter = @word[i]
      if @correct_guesses.include? letter
        save += letter
      else
        save += '-'
      end
    end
    return save
  end

  def invalid(word)
    if (word == '') or (word == nil) or !(word =~ /[a-zA-z]/)
      raise ArgumentError
    end
  end

  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      return :lose 
    elsif word_with_guesses == @word
      return :win
    else
      :play
    end
  end



end