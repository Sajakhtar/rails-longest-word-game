require 'open-uri'
require 'json'
# Games Controller
class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    @attempt = params[:attempt]
    @grid = params[:grid].split('')

    @result = get_result(@attempt, @grid)
  end
end

def english_word?(word)
  url = "https://wagon-dictionary.herokuapp.com/#{word}"
  word_serialized = URI.open(url).read
  word_api = JSON.parse(word_serialized)
  word_api['found']
end

def get_score(word, grid)
  (word.size.to_f / grid.size * 100)
end

def get_result(word, grid)
  if english_word?(word)
    condition = word.upcase.chars.all? { |char| grid.count(char) >= word.upcase.chars.count(char) }
    return { score: get_score(word, grid), message: 'is a valid word. Well Done!' } if condition

    return { score: 0, message: "does not contain characters from the grid of letters: #{grid.join(', ')}!" }
  end
  { score: 0, message: 'is not an English word!' }
end
