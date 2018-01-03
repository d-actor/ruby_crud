require 'httparty'
require 'pry'

BASE_URL = 'http://json-server.devpointlabs.com/api/v1'

def menu
  puts '---RUBY DPL API---'
  puts '1) All users'
  puts '2) Look Up User by ID'
  puts '3) Add a user'
  puts "Type 'quit' at any time to quit"
  puts 'Selection: '
  @selection = STDIN.gets.strip
end

def users_index
  users = HTTParty.get("#{BASE_URL}/users").parsed_response
  users.each do |user|
    puts user['id']
    puts user['first_name']
    puts user['last_name']
    puts user['phone_number']
  end
end

def user_show
  puts 'Enter the user ID:'
  id = STDIN.gets.strip.to_i
  user = HTTParty.get("#{BASE_URL}/users/#{id}").parsed_response
  puts user['first_name']
  puts user['last_name']
  puts user['phone_number']
end

def user_create
  puts 'Enter the users first name:'
  first = STDIN.gets.strip
  puts 'Enter the users last name:'
  last = STDIN.gets.strip
  puts 'Enter the users phone number:'
  number = STDIN.gets.strip
  new_user = HTTParty.post("#{BASE_URL}/users/user#{first}#{last}#{number}")
end

loop do
  case menu
    when '1'
      users_index
    when '2'
      user_show
    when '3'
      user_create
    when "Quit", "quit", "q", "QUIT", "Q"
      puts "Goodbye!"
      break
    else
      puts "Invalid selection, try again my dude"
  end
end
