#
# Push Message Send for Ruby (GCM 3.0)
# 
# last update 2016.01.20
#
# hwj4477@gmail.com
#

require 'net/http'
require 'json'

class GcmSendDownstream

  PLATFORM_IOS = "iOS"
  PLATFORM_ANDROID = "Android"

  def initialize(auth_key, app_title)

    # GCM API KEY : https://developers.google.com/cloud-messaging/
    @auth_key = auth_key
    @app_title = app_title

  end

  def send_message(platform, registration_ids, message, data = nil)

    params = nil

    if platform == PLATFORM_IOS

      params = {

        'notification' => {'title' => @app_title,
                           'body' => message,
                           'sound' => 'default'},
        'priority' => 'high', 
        'registration_ids' => registration_ids

      }.to_json

      params['data'] = data if data

    else

      params = {
        'data' => {'title' => @app_title,
                   'message' => message},
        'registration_ids' => registration_ids

      }.to_json

      params['data'].merge(data) if data

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
  
  def send_message_silent(platform, registration_ids, data = nil)

    params = {

      'data' => data,
      'registration_ids' => registration_ids,
      'priority' => 5,
      'content_available' => true

    }.to_json

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
