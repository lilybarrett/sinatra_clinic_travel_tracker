### A Brief Announcement
* The first week can be tough. Help each other by using the Question Queue!

```ruby
your_question == shared_by_10_other_launchers
```

![alt text](https://imgs.xkcd.com/comics/wisdom_of_the_ancients.png)

### What is Sinatra?

* Sinatra is a free and open-source lightweight web application framework
* unlike other Ruby frameworks (such as Rails), Sinatra emphasizes a minimalistic approach to development, only offering what is essential to handle HTTP requests
* Sinatra is ideal for learning HTTP since its syntax in defining endpoints uses HTTP verbs (GET, POST, etc.) in the pattern `verb ‘route’ do`

---

### Routes

* Sinatra is built on a series of routes defined in app.rb/server.rb
* routes can essentially be seen as methods in Ruby of a specific syntax
* just as Ruby methods only have one return value, and once returned jumps out of the method even if there are more lines of code in the block, Sinatra can only have one return, for example redirecting to a different route
* if the situation calls for it you can use conditionals to redirect/render things based on certain conditions

```ruby
# the pry after the redirect will never be hit because the redirect will cause an exit of the block / method
post '/traveled_to_list' do
  latest_trip = params[:latest_trip]

  File.open('traveled_to_list.txt', 'a') do |file|
    file.puts(latest_trip)
  end

  redirect '/'
  binding.pry
end
```

* to declare a route you supply the HTTP verb to respond to, the URL/path, and a block of code you want executed if someone travels to/hits that route on the client
* one thing to remember is that many routes may have the same URL, but different actions can be triggered/called based on the type of HTTP verb

```ruby
require 'sinatra'

get '/traveled_to_list' do
  # triggered via GET
  # retrieving info from server
  # page with list of destinations traveled to
end

post '/traveled_to_list' do
  # triggered via POST
  # sending info to server
  # submitting a form to add a destination to our list
end
```
---

### Params

* the params hash stores query string and data, which is how we pass data from our client to the server
* a hash is just made up of key-value pairs, what determines the keys?

* in forms, this is the ‘name’ part of your form input
* for queries, or "get" requests from your browser, params will be defined by the pattern of your route in the server file

```ruby
get '/traveled_to_list/:trip' do
  @trip = params[:trip]
  binding.pry
  erb :show
end
```

the symbol id at the end of the path becomes the key in our key-value pair of our params hash, so if it was defined as

```ruby
get '/traveled_to_list/:this_is_a_random_key' do
  @trip = params[:this_is_a_random_key]
  binding.pry
  erb :show
end
```

now going to that url `http://localhost:4567/traveled_to_list/korea`, we still have the same value, but with a key of “this_is_a_random_key": `{this_is_a_random_key: "korea"}`

---

### Instance Variables

* this is how we pass data from our server to our views, and we commonly use `erb` templates as to dynamically generate our html

```ruby
# server.rb
get '/' do
  @traveled_to_list = File.readlines('traveled_to_list.txt')

  erb :index
end
```

---

### Views

* Sinatra will default to look in your views folder

```ruby
# server.rb
# looks in views folder for index.erb
get '/' do
  @traveled_to_list = File.readlines('traveled_to_list.txt')

  erb :index
end
```

* if your template is in a subfolder, for example if you follow a pattern to have a folder for each model so each subfolder can have its own index.erb, you need to convert the string path to a symbol such as

```ruby
erb :'traveled_to_list/index'
```

---

Debugging
=========

### Start by restarting your server

* often when we make changes on the server file and we don’t see that reflected on the webpage, it is because we forgot to restart the server

### Throw a pry in it

* erb is just embedded ruby, you can use pry simply by throwing `<% binding.pry %>` into your erb file!

---
### Travel Tracker
```
checklist -
[ ]  visiting ‘/traveled_to_list’ should show me an unordered list of all the locations from the txt file, with each location as its own <li> element
[ ]  as a user I want to be able to add recent trip destinations via a form that should add it to ‘traveled_to_list.txt’, then it should redirect me to the page I was just on, ‘/traveled_to_list’, so I can see all the previous entries plus the new location I just submitted
[ ]  root should redirect to “/traveled_to_list"
```
