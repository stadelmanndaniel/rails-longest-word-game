require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    grid_alphabet = ('A'..'Z').to_a
    @letters = 10.times.map { grid_alphabet.sample }
  end

  def score
    # raise
    # if @letters.upcase
    # end
    user_word = params[:user_word]
    @score = word_included(user_word)
  end

  def word_included(user_word)
    user_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{user_word}")
    user = JSON.parse(user_serialized.read)
    letters = params[:letters].split
    # raise
    if user['found'] == true
      letters_used(user_word, letters)
      # letters_used(user_word)
    else
      @result = "Sorry but #{user_word.upcase} does not seem to be a valid english word"
    end
  end

  def letters_used(user_word, letters)
    if user_word.chars.all? { |letter| letters.include?(letter.capitalize) }
      @result = "Congratulations! #{user_word.upcase} is a valid English word"
    else
      @result = "Sorry but #{user_word.upcase} can't be built of ouf #{letters.join}"
    end
  end
end
