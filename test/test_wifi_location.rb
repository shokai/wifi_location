require File.dirname(__FILE__) + '/test_helper.rb'

class TestWiFiLocation < Test::Unit::TestCase
  def setup
    @location = WiFiLocation.location
  end

  def test_location
    assert @location.class == Hash
    assert @location['latitude'].class == Float
    assert @location['longitude'].class == Float
    assert @location['address'].class == Hash
    assert @location['accuracy'].class == Float
  end
end
