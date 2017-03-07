require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(101)
@@guesses = 5
set :color => "", :message => ""

get '/' do
  guess = params['guess'].to_i
  settings.message = check_guess(guess)

  @@guesses -= 1

  if settings.color == "green"
    SECRET_NUMBER = rand(101)
    @@guesses = 5
  elsif @@guesses == 0
    settings.message = "You lose! The SECRET NUMBER was #{SECRET_NUMBER}. A new SECRET NUMBER has been generated, so try again!"
    settings.color = "red"
    SECRET_NUMBER = rand(101)
    @@guesses = 5
  end

  erb :index, :locals => {:message => settings.message, :color => settings.color}
end

def check_guess(guess)
  if guess > (SECRET_NUMBER + 5)
    settings.color = "red"
    "Way too high!"
  elsif guess > SECRET_NUMBER
    settings.color = "pink"
    "Too high!"
  elsif guess < (SECRET_NUMBER - 5)
    settings.color = "red"
    "Way too low!"
  elsif guess < SECRET_NUMBER
    settings.color = "pink"
    "Too low!"
  else
    settings.color = "green"
    "You got it right!<br/><br/>The SECRET NUMBER was #{SECRET_NUMBER}. To play again, enter a guess for the new SECRET NUMBER!"
  end
end
