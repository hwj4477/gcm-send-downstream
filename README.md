# Push Message Send for Ruby (GCM 3.0)
- rubygems : http://rubygems.org/gems/gcm-send-downstream

# Installation
```sh
$ gem install gcm-send-downstream
```

# Example usage
```ruby
require 'gcm-send-downstream'

# Google API Auth Key, App Title (Push Message Title)
API_KEY = ""
APP_TITLE = ""

# GCM Registration_ids (Array)
REGISTRATION_IDS = []
    
gcm_sender = GcmSendDownstream.new(API_KEY, APP_TITLE)
gcm_sender.send_message(REGISTRATION_IDS, "Test Message") do |result, message|

    puts "result : #{result}"
    puts "message : #{message}"

end
```
