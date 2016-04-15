#suggested classes: Game to host everything, a Combo object that holds combinations and returns arrays of 

#point of game: two players, one selects a pattern of colors and the second makes attempts to identify that 
#pattern
#After guessing a pattern, the game tells the player if the colors are correct, and if they are in the correc
#position
require "./substrings.rb"

class Game

  def initialize
    @guesses = 0
    @max_guesses = 10
    start_game
  end

  def start_game
    @game_over = false

    puts "What is your name?"
    name = gets.chomp
    puts "Would you like to guess or set the code? (guess/set)"
    user_input = gets.chomp

    if user_input == "guess"
      @guesser = Guesser.new(name)
      @master = Master.new("Computer")
      @master.create_code

      until @game_over || @guesses >= @max_guesses
        
        @game_over = check_win?( guess )

        @guesses += 1
      end

      puts @game_over ? "Congrats #{@guesser.name}, you guessed correctly" : "Congrats #{@master.name}!"

    elsif user_input == "set"
      @guesser = Guesser.new("computer")
      @master = Master.new(name)
      @master.create_code
    else
      puts "bad input"
    end
  end

  def check_win?(results)
    indicator_frequencies = substrings(results.values.join(" "), ["black"])
    if indicator_frequencies["black"] == 4
      return true
    end
    false
  end


  def get_input
    puts "Please enter four valid colors (red, green, black, blue, yellow)"
    user_input = gets.chomp.split(" ")
  end

  def guess
    user_input = get_input
    user_guess = Code.new(user_input[0], user_input[1], user_input[2], user_input[3])
    @master.code.compare(user_guess)
  end


  class Player
    attr_accessor :name
    def initialize(name)
      @name = name.capitalize      
    end
  end

  class Guesser < Player

  end

  class Master < Player
    attr_accessor :code

    def create_code
      colors = %w(red green black blue yellow)
      @code = Code.new(colors.sample, colors.sample, colors.sample, colors.sample)
    end
  end

  class Code
    #attr_accessor :one, :two, :three, :four 
    attr_accessor :code    

    def initialize(one, two, three, four)
      @code = Hash.new
      @code[:one] = one
      @code[:two] = two
      @code[:three] = three
      @code[:four] = four
    end

    def compare(other_code)
      results = Hash.new("")      
      results = set_blacks(other_code, results)
      results = set_whites(other_code, results)
      show_comparison(results)
      results
    end

    def set_whites(other_code, results)
      #already made method counts frequencies of words in one string against an array, returns hash
      #Need to pull the blacks out first 

      remaining_results = other_code.code.reject do |key, value|
        results.has_key?(key)
      end

      remaining_master = @code.select do |key, value|
        remaining_results.has_key?(key)
      end

      similarities = substrings(remaining_results.values.join(" "), remaining_master.values)

      remaining_results.each do |key, value|

        if similarities[value] > 0
          results[key] = "white"
          similarities[value] -=1
        end            
      end

      results
    end

    def set_blacks(other_code, results)
      keys = @code.keys

      keys.each do |key|
        results[key] = "black" if @code[key] == other_code.code[key] 
      end

      results
    end

    def show_comparison(results)
      puts results.keys.join(" ")
      puts results.values.join(" ")
    end
  end
end
