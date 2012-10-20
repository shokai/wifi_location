require File.dirname(__FILE__) + '/test_helper.rb'
require 'wifi_location/logger'

class TestPos < Test::Unit::TestCase
  def setup
    @towers = WiFiLocation.wifi_towers
    @pos = WiFiLocation::Pos.new
    @pos.towers = @towers
    @pos.time = Time.now
  end

  def test_read_write
    pos2 = WiFiLocation::Pos.new @pos.to_s
    assert pos2.towers == @pos.towers
    assert pos2.time.to_i == @pos.time.to_i
  end
end
