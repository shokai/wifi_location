#!/usr/bin/env ruby
require 'rubygems'
require 'wifi_location'
loc = WiFiLocation.location
puts "#{loc['latitude']}, #{loc['longitude']}"
p loc
