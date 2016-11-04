require_relative('htp') 


def get_google_map_data

  begin

    eg = EHtp.new('maps.googleapis.com')
    query_param = {address: '11234 Broadway, New York, NY', sensor: 'false'}
    response = eg.get_test_data(query_param)

    puts "\nResponse is: #{response}\n"

    hash_xml = Crack::XML.parse(response.body)
  
    # pretty print to screen
    puts "\nPretty print the output\n"
    puts JSON.pretty_generate(hash_xml)
    

  rescue => e
    puts "\nError! #{e}\n"
      
  end

end



get_google_map_data