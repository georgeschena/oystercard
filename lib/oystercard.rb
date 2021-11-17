class Oystercard
  def initialize(balance)
    @balance = balance
    @tapped_in_station = nil
    @tapped_out_station = nil
    @fare = 0
  end

  def tap_in(station_start)
    station = Stations.new.fetch_station(station_start)
    @tapped_in_station = station
    @fare = 3.20
  end

  def tap_out(station_end)
    station = Stations.new.fetch_station(station_end)
    @tapped_out_station = station
  end

  def calculate_fare
    return false if @tapped_out_station.nil?

    if anywhere_in_zone_1
      @fare = 2.50
    elsif any_two_zones_excluding_zone_1
      @fare = 2.25
    elsif any_one_zone_outside_zone_1
      @fare = 2.00
    elsif any_two_zones_including_zone_1
      @fare = 3.00
    end

    @balance = @balance - @fare
  end

  def anywhere_in_zone_1
    @tapped_in_station.include?(1) && @tapped_out_station.include?(1)
  end

  def any_one_zone_outside_zone_1
    @tapped_in_station.delete(1) if @tapped_in_station.length > 1
    @tapped_out_station.delete(1) if @tapped_out_station.length > 1

    zone_diff = (@tapped_in_station.first - @tapped_out_station.first).abs

    if zone_diff == 0
      true
    else
      false
    end

  end

  def any_two_zones_including_zone_1
    zone_diff = (@tapped_in_station.first - @tapped_out_station.first).abs

    if zone_diff == 1
      true
    else
      false
    end
  end

  def any_two_zones_excluding_zone_1
    if @tapped_in_station.include?(1) ||  @tapped_out_station.include?(1)
      return false
    end

    zone_diff = (@tapped_in_station.max - @tapped_out_station.max).abs

    if zone_diff == 1
      true
    else
      false
    end
  end

  attr_reader :balance
  attr_reader :tapped_in_station
  attr_reader :tapped_out_station
  attr_reader :fare
end
