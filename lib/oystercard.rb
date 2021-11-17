class Oystercard
  def initialize(balance)
    @balance = balance
    @tapped_in_station = nil
    @tapped_out_station = nil
  end

  def tap_in(station_start)
    station = Stations.new.fetch_station(station_start)
    @tapped_in_station = station
  end

  def tap_out(station_end)
    station = Stations.new.fetch_station(station_end)
    @tapped_out_station = station
  end

  

  attr_reader :balance
  attr_reader :tapped_in_station
  attr_reader :tapped_out_station

end
