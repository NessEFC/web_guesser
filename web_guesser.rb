require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(101)
set :number => SECRET_NUMBER, :color => ""

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:message => message, :color => settings.color}
end

def check_guess(guess)
  if guess > (settings.number + 5)
    settings.color = "red"
    "Way too high!"
  elsif guess > settings.number
    settings.color = "pink"
    "Too high!"
  elsif guess < (settings.number - 5)
    settings.color = "red"
    "Way too low!"
  elsif guess < settings.number
    settings.color = "pink"
    "Too low!"
  else
    settings.color = "green"
    "You got it right!<br/><br/>The SECRET NUMBER is #{settings.number}"
  end
end
