require_relative('dh_htp_wp_rest_api') 

HOST_IP = 'mydomino.dreamhosters.com'


def get_posts

  begin

  	dh = DHHtp.new(HOST_IP)
  	#query_param = {filter: {posts_per_page: 6, page:3}}
    query_param = {page: 1, per_page: 4}
    
    #query_param = {json: 'core.info', controller: 'core'}
  	response = dh.get_posts(query_param)

    #puts "\nResponse is: #{response}\n"
    dh.display_posts(response)
    

  rescue => e
  	puts "\nError! #{e}\n"
      
  end

end


def pretty_print_posts_from_api

  begin

    dh = DHHtp.new(HOST_IP)
    query_param = {page: 1, per_page: 20}
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

    dh = DHHtp.new(HOST_IP)
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



get_posts
#pretty_print_posts_from_api
#get_recent_posts

