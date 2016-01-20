require 'minitest/autorun'
require 'gcm-send-downstream'

API_KEY = ""
APP_TITLE = ""
REGISTRATION_IDS = []

sender = GcmSendDownstream.new(API_KEY, APP_TITLE)

sender.send_message(GcmSendDownstream::PLATFORM_IOS, REGISTRATION_IDS, 'Test iOS Message') do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end

sender.send_message_silent(GcmSendDownstream::PLATFORM_IOS, REGISTRATION_IDS) do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end
