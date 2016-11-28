require_relative('dh_htp_wp_rest_api') 

#HOST_IP = 'mydomino.dreamhosters.com'


def get_posts

  begin

  	dh = DHHtp.new(DHHtp::HOST_IP)
  	#query_param = {filter: {posts_per_page: 6, page:3}}
    query_param = {page: 2, per_page: 8}
    
    #query_param = {json: 'core.info', controller: 'core'}
  	response = dh.get_posts(query_param)

    #puts "\nResponse is: #{response}\n"
    puts "\nResponse header is: #{response.headers.inspect}\n"
    dh.get_pagination_params(response.headers)


    dh.display_posts(response.body)
    

  rescue => e
  	puts "\nError! #{e}\n"
      
  end

end



def get_post_by_id(id)

  begin

    id = id.to_i

    dh = DHHtp.new(DHHtp::HOST_IP)
    #query_param = {filter: {posts_per_page: 6, page:3}}
    query_param = {page: 1, per_page: 4}
    
    #query_param = {json: 'core.info', controller: 'core'}
    response = dh.get_post_by_id(id, query_param)

    #puts "\nResponse is: #{response}\n"
    puts "\nResponse header is: #{response.headers.inspect}\n"


    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end


def pretty_print_posts_from_api

  begin

    dh = DHHtp.new(DHHtp::HOST_IP)
    query_param = {page: 1, per_page: 10}
    #query_param = {json: 'core.info', controller: 'core'}
    response = dh.get_posts(query_param)

    #puts "\nResponse is: #{response}\n"

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end





def get_recent_posts

  begin

    dh = DHHtp.new(DHHtp::HOST_IP)
    #query_param = {json: '1'}
    query_param = {json: 'core.get_recent_posts'}
    response = dh.get_posts(query_param)

    #puts "\nResponse is: #{response}\n"

    # save data to file - i stands for instant data
    #dh.save_data_to_file('i', response.body)
  

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end




def get_categories

  begin

    dh = DHHtp.new(DHHtp::HOST_IP)
    #query_param = {filter: {posts_per_page: 6, page:3}}
    query_param = {}
    
    #query_param = {json: 'core.info', controller: 'core'}
    response = dh.get_categoriess(query_param)

    #puts "\nResponse is: #{response}\n"
    puts "\nResponse header is: #{response.headers.inspect}\n"

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))
    
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end




def get_post_by_slug(slug)

  begin

    dh = DHHtp.new(DHHtp::HOST_IP)
    #query_param = {filter: {posts_per_page: 6, page:3}}
    query_param = {filter: {name: slug}}
    
    #query_param = {json: 'core.info', controller: 'core'}
    response = dh.get_post_by_slug(query_param)

    #puts "\nResponse is: #{response}\n"
    puts "\nResponse header is: #{response.headers.inspect}\n"

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))


    puts "\n\n\nDisplaying post(s) ....\n"
    dh.display_posts(response.body)
    
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end



def get_posts_by_category(categry_slug)

  begin

    dh = DHHtp.new(DHHtp::HOST_IP)
    
    query_param = {filter: {category_name: categry_slug}}
    
    
    response = dh.get_post_by_slug(query_param)

    #puts "\nResponse is: #{response}\n"
    puts "\nResponse header is: #{response.headers.inspect}\n"

    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(JSON.parse(response.body))


    puts "\n\n\nDisplaying post(s) ....\n"
    dh.display_posts(response.body)
    
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

  
end


#get_posts
#pretty_print_posts_from_api
#get_recent_posts
#get_post_by_id('3383')
#get_categories
#get_post_by_slug('how-to-switch-to-leds-2')
#get_post_by_slug('7-things-thankful-mydomino')
#get_posts_by_category('Transportation')
#get_posts_by_category('energy-freedom')
#get_posts_by_category('heating-and-cooling')
get_posts_by_category('clean-power')
