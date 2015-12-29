Push Message Send for Ruby (GCM 3.0)
=============
- rubygems : <a href="http://rubygems.org/gems/gcm-send-downstream">gcm-send-downstream</a>

Installation
============

    gem install gcm-send-downstream


Example usage
=============

    require 'gem-send-downstream'
    
    gcm_sender = GcmSendDownstream(API_KEY, APP_TITLE)
    gcm_sender.send_message(REGISTRATION_IDS, "Test Message") do |result, message|

        puts "result : #{result}"
        puts "message : #{message}"

    end
