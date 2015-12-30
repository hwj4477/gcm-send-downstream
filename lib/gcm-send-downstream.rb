#
# Push Message Send for Ruby (GCM 3.0)
# 
# 2015. 12. 29
# hwj4477@gmail.com
#

require 'net/http'
require 'json'

class GcmSendDownstream

  def initialize(auth_key, app_title)

    # GCM API KEY : https://developers.google.com/cloud-messaging/
    @auth_key = auth_key
    @app_title = app_title

  end

  def send_message(registration_ids, message, silent = false, silent_data = nil)

    unless silent

      params = {

        'notification' => {'title' => @app_title,
                           'body' => message},
        'data' => {'title' => @app_title,
        'message' => message},
        'registration_ids' => registration_ids

      }.to_json

    else

      params = {

        'data' => silent_data,
        'registration_ids' => registration_ids,
        'content_available' => true

      }.to_json

    end

    uri = URI.parse("https://gcm-http.googleapis.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
 
    request = Net::HTTP::Post.new("/gcm/send")
    request.add_field("Authorization", "key=#{@auth_key}")
    request.add_field("Content-Type", "application/json")
    request.body = params
    response= http.request(request)

    # Json Parse
    begin

      results = JSON.parse(response.body)

    rescue JSON::ParserError => e

      str_error =  "JSON Parse Error (#{e})"
      yield false, str_error
      return

    end

    gcm_results = results["results"]
 
    gcm_results.each_with_index do |gcm_result, index|
 
      yield true, gcm_result

    end 

  end

end
