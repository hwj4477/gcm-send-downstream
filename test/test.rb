require 'minitest/autorun'
require 'gcm-send-downstream'

API_KEY = ""
REGISTRATION_IDS = []

sender = GcmSendDownstream.new(API_KEY, 'test title')

sender.send_message(REGISTRATION_IDS, 'test message') do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end
