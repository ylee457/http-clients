require 'httparty'
require 'json'
require 'crack' 


class EHtp
	include HTTParty
	#base_uri 'maps.googleapis.com'
	debug_output STDOUT

	def initialize(host_ip)
		@host_ip = host_ip
		#base_uri = host_ip
	end


  def get_test_data(query_options)

	  puts "Google MAP API Data\n"
	  self.class.base_uri 'maps.googleapis.com'

    puts "\nQuery options is: #{query_options}"

    
    #response = self.class.get("http://maps.googleapis.com/maps/api/geocode/xml?address=11234+Broadway,+New+York,+NY&sensor=false")
    response = self.class.get("/maps/api/geocode/xml", query: query_options)
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

    
    puts "\nParams sent to URL is: #{response.request.last_uri.to_s}"

	  if response.success?
      response
    else
      raise response.response
    end
  
  end



end