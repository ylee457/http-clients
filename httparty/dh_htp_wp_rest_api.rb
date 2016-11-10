require 'httparty'
require 'json'
require 'crack'
require 'date'


class DHHtp
	include HTTParty

	#debug_output STDOUT


	def initialize(host_ip)
		@host_ip = host_ip
		#base_uri = host_ip
	end



	def get_posts(query_options)

	  puts "Getting Posts from Dreamhost with WP REST API V2...\n"

	  # set the base URL 
	  self.class.base_uri(@host_ip)

	  paswd = ENV['egauge_password']
    puts "paswd is: #{paswd}"

    # set digest authentication
	  self.class.digest_auth('owner', paswd)

	  #url = "http://#{@host_ip}/cgi-bin/egauge?tot&inst&teamstat&v1"
    
    puts "\nQuery options is: #{query_options}"

    
    response = self.class.get("/wp-json/wp/v2/posts", query: query_options)
    #response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end

  def display_posts(response)

     # convert JSON string to hash
    posts = JSON.parse(response.body)

    puts "Total #{posts.size} posts:"

    posts.each do |i|

      puts "\n\n======================================"
      puts "POST title: #{i['title']['rendered']}"
      puts "POST ID: #{i['id']}"
      puts "POST date: #{i['date']}"
      puts "POST slug: #{i['slug']}"
      puts "POST type: #{i['type']}"
      puts "POST link: #{i['link']}"
      puts "POST excerpt: #{i['excerpt']['rendered']}"    
      puts "POST content: #{i['content']['rendered']}"
      
    end

  end



end