module WiFiLocation
  class Pos
    attr_accessor :time, :towers

    def initialize
      @time = Time.now
      @towers = []
    end

    def parse(line)
      if line.kind_of? String
        time, towers = line.split(/\t+/)
        @time = Time.at time.to_i
        @towers = JSON.parse towers
      end
      self
    end

    def to_s
      "#{@time.to_i}\t#{@towers.to_json}"
    end
  end
end
