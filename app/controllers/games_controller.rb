require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @letters = alphabet.sample(10)
    @letters
  end

  def score
  @answer = params["answer"]
  attempt = @answer
  grid = params["token"].chars

  check = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{attempt}").read)
  @message = { score: 0, message: "not an english word"}
  inclu = attempt.upcase.chars.all? { |letter| attempt.upcase.count(letter) <= grid.count(letter) }
  if check["found"] && inclu
    @message[:score] = check["length"] * 100
    @message[:message] = "Well Done!"
  elsif check["found"] && !inclu
    @message[:message] = "not in the grid"
  end
  @message
  end

end
