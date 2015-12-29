require 'minitest/autorun'
require 'gcm-send-downstream'

API_KEY = ""
APP_TITLE = ""
REGISTRATION_IDS = []

sender = GcmSendDownstream.new(API_KEY, APP_TITLE)

sender.send_message(REGISTRATION_IDS, 'Test Message') do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end
