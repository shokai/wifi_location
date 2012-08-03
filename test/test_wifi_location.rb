require File.dirname(__FILE__) + '/test_helper.rb'

class TestWiFiLocation < Test::Unit::TestCase
  def setup
    @location = WiFiLocation.location
  end

  def test_location
    assert @location.class == Hash
  end

  def test_latitude
    assert @location['latitude'].class == Float
  end

  def test_longitude
    assert @location['longitude'].class == Float
  end

  def test_address
    assert @location['address'].class == Hash
  end

  def test_accuracy
    assert @location['accuracy'].class == Float
  end
end
