module WiFiLocation
  class Pos
    attr_accessor :time, :towers

    def initialize(line=nil)
      @time = nil
      @towers = nil
      if line.kind_of? String
        time, towers = line.split(/\t+/)
        @time = Time.at time.to_i
        @towers = JSON.parse towers
      end
    end

    def to_s
      "#{@time.to_i}\t#{@towers.to_json}"
    end
  end
end
