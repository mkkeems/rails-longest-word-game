require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [];
    alphabet = ('a'..'z').to_a
    vowels = ["a", "e", "i", "o", "u"]
    @time = Time.now

    until @letters.length === 9
      @letters << alphabet[rand(0..25)]
    end

    # until @letters.length === 10
      @letters << vowels[rand(0..4)]
    # end
  end

  def score
    @time =Time.now
    @time_started = params[:start_time].to_datetime

    @time_taken = (@time-@time_started).round

    @user_answer = params[:answer]

    @user_answer_array = @user_answer.chars
    @letters_array = params[:letters_array].split
    @result = ''

    @poop = @user_answer_array-@letters_array
    @score = 0

    if (@poop).empty?
      if checkword(@user_answer)["found"]
        @result = 'You made a word!'
        @score += checkword(@user_answer)["length"]
      else
        @result = "You made a word but it's not really a word..."
      end
    else
      @result = "The word you made doesn't fit the options"
    end

  end

  def checkword(word)
    uri = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(uri).read
    @response = JSON.parse(response)
    # raise
  end
end
