require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(101)
set :number, SECRET_NUMBER

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:message => message}
end


def check_guess(guess)
  if guess > (settings.number + 5)
    message = "Way too high!"
  elsif guess > settings.number
    message = "Too high!"
  elsif guess < (settings.number - 5)
    message = "Way too low!"
  elsif guess < settings.number
    message = "Too low!"
  else
    message = "You got it right!<br/><br/>The SECRET NUMBER is #{settings.number}"
  end
end
