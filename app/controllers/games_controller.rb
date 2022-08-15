require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @grid = ('a'..'z').to_a.sample(10)
  end

  def score
    @grid = params[:grid].split(' ')
    @word = params[:word].split('')
    @output_string = ''


    @word.each do |letter|
      index = @grid.index(letter)
      if @grid.index(letter)
        @grid.delete_at(index)
        @output_string = 'Sorry this is not an English word'
        url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
        word_serialized = URI.open(url).read
        @output_string = 'Correct! Your score is:' if JSON.parse(word_serialized)['found']
        @score = params[:word].size * 100
      else
        @output_string = 'Your word is not within the grid'
      end
    end



    # for each letter in the word, check if it is in the grid, if it is, delete it from the grid
  end
end
