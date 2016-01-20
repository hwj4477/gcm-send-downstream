# Push Message Send for Ruby (GCM 3.0)
- rubygems : http://rubygems.org/gems/gcm-send-downstream

## Installation
```sh
$ gem install gcm-send-downstream
```

## Usage ##
```ruby
require 'gcm-send-downstream'

# Google API Auth Key, App Title (Push Message Title)
API_KEY = ""
APP_TITLE = ""

# GCM Registration_ids (Array)
REGISTRATION_IDS = []

sender = GcmSendDownstream.new(API_KEY, APP_TITLE)

# iOS(PLATFORM_IOS) / Android(PLATFORM_ANDROID)
sender.send_message(GcmSendDownstream::PLATFORM_IOS, REGISTRATION_IDS, 'Test iOS Message') do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end

sender.send_message_silent(GcmSendDownstream::PLATFORM_IOS, REGISTRATION_IDS) do |result, message|

  p "result : #{result}"
  p "message : #{message}"

end

```
