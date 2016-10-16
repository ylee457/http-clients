

require 'rest-client'
require 'json'



puts "Example 1.\n\n"
 
url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
response = RestClient.get(url)
a = JSON.parse(response)
puts a

#########################
puts "\n\n\n\n\n"

puts "Example 2.\n\n"

resp = RestClient.get 'http://mydomino.com'
puts "Resp 2 is #{resp}\n\n"

puts "Resp code 2 is #{resp.code}\n\n"


#########################
puts "Example 3.\n\n"

# youtube video
resp = RestClient.get 'https://www.youtube.com/watch?v=36M2BSA2LYk'
puts "Resp 3 is #{resp}\n\n"

puts "Resp code 3 is #{resp.code}\n\n"


############################
puts "Example 4.\n\n"

# A wrong/dummy youtube video

begin
	resp = RestClient.get 'https://www.youtube.com/watch?v=jdhhhdd'
	#puts "Resp 4 is #{resp}\n\n"

	puts "Resp code 4 is #{resp.code}\n\n"
rescue RestClient::NotFound => e
	puts "Error: #{e.message}\n\n"
end

###################################


puts "Example 4.\n\n"

# A wrong/dummy youtube video

begin
	resp = RestClient.get 'http://mydomino.com'
	puts "Resp 4 is #{resp}\n\n"

	#result = JSON.parse(resp)
    #puts result.to_json

	puts "Resp code 4 is #{resp.code}\n\n"
rescue RestClient::NotFound => e
	puts "Error: #{e.message}\n\n"
end
