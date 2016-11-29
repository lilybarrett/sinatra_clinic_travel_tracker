require 'sinatra'
require 'pry'

get "/" do
  redirect "/traveled_to_list"
  #test comment
end

get '/traveled_to_list' do
  @traveled_to_list = File.readlines('traveled_to_list.txt')

  erb :index
end

post "/traveled_to_list" do
  latest_trip = params[:latest_trip]
  File.open('traveled_to_list.txt', 'a') do |file|
    file.puts(latest_trip)
  end

  redirect "/traveled_to_list"
end
