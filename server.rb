require 'Sinatra'
require 'pry'

get "/" do
  redirect "/traveled_to_list"
end

get '/traveled_to_list' do
  @traveled_to_list = File.readlines('traveled_to_list.txt')

  erb :index
end

post "/traveled_to_list" do
  latest_trip = params[:trip]
  File.open('traveled_to_list.txt', 'a') do |file|
    file.puts(latest_trip)
  end
end
