module WiFiLocation

  def self.wifi_towers
    case RUBY_PLATFORM
    when /darwin/
      lines = `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s`.split(/[\r\n]/)
      lines.shift
      lines.map{|i|
        a = i.scan(/[^\s]+/)
        {'bssid' => a[1], 'signal' => a[2].to_i}
      }
    when /linux/
      lines = `iwlist wlan0 scan`.split(/[\r\n]/)
      addrs = []
      lines.each do |line|
        addrs.push({'bssid' => line.split(/\s+/).last, 'signal' => 8}) if line =~ /Address: /
        addrs.last['signal'] = line.scan(/Signal level[:=](\-?\d+)/)[0][0].to_i rescue next if line =~ /Signal level[:=]/
      end
      addrs
    end
  end

  def self.location(wifi_towers=self.wifi_towers)
    uri = URI.parse 'http://www.google.com/loc/json'
    query = {
      :version => '1.1.0',
      :host => 'maps.google.com',
      :request_address => true,
      :address_language => ENV['LANG'] ? ENV['LANG'].scan(/([^\.]+)/)[0][0] : 'en_US',
      :wifi_towers => wifi_towers.map{|tower| {:mac_address => tower['bssid'], :signal_strength => tower['signal'], :age => 0} }
    }.to_json
    headers = {'Content-Type' => 'application/json'}
    res = Net::HTTP.start(uri.host, uri.port).request(Net::HTTP::Post.new(uri.request_uri, headers), query)
    raise "Response Error (#{res.code})" unless res.code.to_i == 200
    JSON.parse(res.body)['location']
  end

end
