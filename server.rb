require 'sinatra'
require 'pry'

get "/" do
  redirect "/traveled_to_list"
end

get '/traveled_to_list' do
  @traveled_to_list = File.readlines('traveled_to.txt')

  erb :index
end

post "/traveled_to_list" do
  latest_trip = params[:traveled_to]
  File.open('traveled_to.txt', 'a') do |file|
    file.puts(latest_trip)
  end

  redirect "/traveled_to_list"
end
