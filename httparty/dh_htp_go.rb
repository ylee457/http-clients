require_relative('dh_htp') 

HOST_IP = 'mydomino.dreamhosters.com'


def get_posts

  begin

  	dh = DHHtp.new(HOST_IP)
  	query_param = {json: '1'}
    #query_param = {json: 'core.info', controller: 'core'}
  	response = dh.get_posts(query_param)

    puts "\nResponse is: #{response}\n"

    # save data to file - i stands for instant data
    #dh.save_data_to_file('i', response.body)
  

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






# to run: ruby egauge_htp_go.rb data_save/i-10-20-16pm.xml 
def retrieve_xml_structure
 
  begin

  	dh = DHHtp.new('maps.googleapis.com')
  	dh.retrieve_xml_structure(ARGV.first)

  rescue => e
  	puts "\nError! #{e}\n"
  
  end
	
end



#get_posts
get_recent_posts

#retrieve_xml_structure
