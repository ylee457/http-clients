require 'httparty'
require 'json'
require 'crack'
require 'date'
require 'nokogiri'

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

      puts "\n\n\n======================================"
      puts "POST title: #{i['title']['rendered']}\n"
      puts "POST ID: #{i['id']}\n"
      puts "Author Name: #{i['author_meta']['display_name']}\n"


      # format date 
      date = DateTime.parse(i['date'])
      formatted_date = date.strftime('%b %d, %Y')
      
      puts "POST date: #{formatted_date}\n"
      puts "POST slug: #{i['slug']}\n"
      puts "POST type: #{i['type']}\n"
      puts "POST link: #{i['link']}\n"
      puts "POST feature image URL: #{i['md_thumbnail']}\n"
      puts "POST excerpt: #{i['excerpt']['rendered']}\n"    
      puts "POST content: #{i['content']['rendered']}\n"

      #get the post image from its content
      html_doc = Nokogiri::HTML(i['content']['rendered'])
      #image_urls = html_doc.search('//img/@src').to_a
      image_urls = html_doc.xpath("//img/@src").collect {|item| item.value.strip}


      puts "Content Image URLs: #{image_urls.inspect}\n"
      
    end

  end



end