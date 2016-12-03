require 'httparty'
require 'json'
require 'crack'
require 'date'
require 'nokogiri'

class DHHtp
	include HTTParty

	#debug_output STDOUT

  HOST_IP = 'https://mydomino.dreamhosters.com'

  # Note: this value is from dreamhosts WP database for category. This value need to be updated if the WP databse is changed.
  MEMBER_ONLY_CATEGORY = 699   


	def initialize(host_ip)
		@host_ip = host_ip

		# set the base URL 
    self.class.base_uri(@host_ip)

    user_name = ENV['WP_user_name']
    paswd = ENV['WP_password']
    puts "WP_user_name is: #{user_name}. paswd is: #{paswd}"

    # set digest authentication
    #self.class.digest_auth('owner', paswd)

    # set up to use basic authentication
    @options = {
      basic_auth: { 
        username: user_name, 
        password: paswd
      }
    }

	end



	def get_posts(query_options)

	  puts "Getting Posts from Dreamhost with WP REST API V2...\n"

	  # set the base URL 
	  #self.class.base_uri(@host_ip)
#
	  #paswd = ENV['egauge_password']
    #puts "paswd is: #{paswd}"
#
    ## set digest authentication
	  #self.class.digest_auth('owner', paswd)

	  #url = "http://#{@host_ip}/cgi-bin/egauge?tot&inst&teamstat&v1"

    # merge the query options with default options
    query_options = @options.merge(query_options)
    
    puts "\nQuery options is: #{query_options}"

    
    response = self.class.get("/wp-json/wp/v2/posts?_embed", query: query_options)
    #response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end


  def get_post_by_id(id, query_options)

    puts "Getting Posts from Dreamhost with WP REST API V2...\n"
    puts "\nQuery options is: #{query_options}"

    
    response = self.class.get("/wp-json/wp/v2/posts/#{id}", query: query_options)
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
    posts = JSON.parse(response)

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


  def get_pagination_params(resp_headers)


      # retrieve the params from response headers
      #resp_headers = response.headers
      a = resp_headers['x-wp-total']
      b = resp_headers['x-wp-totalpages']

      # return the first element in the array for the params
      puts "Total posts: #{a}"
      puts "Total pages: #{b}"

      return ([a, b])
      
  end



  def get_categoriess(query_options)

    puts "Getting categories from Dreamhost with WP REST API V2...\n"

    # set the base URL 
    self.class.base_uri(@host_ip)

    paswd = ENV['egauge_password']
    puts "paswd is: #{paswd}"

    # set digest authentication
    self.class.digest_auth('owner', paswd)

    #url = "http://#{@host_ip}/cgi-bin/egauge?tot&inst&teamstat&v1"
    
    puts "\nQuery options is: #{query_options}"

    
    response = self.class.get("/wp-json/wp/v2/categories", query: query_options)
    #response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

    if response.success?
      response
    else
      raise response.response
    end
  
  end



  def get_post_by_slug(query_options)

    puts "\nQuery options is: #{query_options}"

    # the slug is provided in the query option
    response = self.class.get("/wp-json/wp/v2/posts", query: query_options)
    #response = self.class.get(url)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

    if response.success?
      response
    else
      raise response.response
    end
    
  end







end