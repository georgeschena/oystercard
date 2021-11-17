class Stations
  def fetch_station(station)
    stations = {
      "Holborn" => [1],
      "Earl's Court" => [1, 2],
      "Wimbledon" => [3],
      "Hammersmith" => [2]
    }

    stations[station]
  end
end
