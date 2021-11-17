require "oystercard"
require "stations"

describe Oystercard do
  let(:oystercard) { oystercard = Oystercard.new(30) }

  it "allows a user to add money to their oyster card" do
    expect(oystercard.balance).to eq(30)
  end

  it "Returns the zones for the tapped in station" do
    oystercard.tap_in("Earl's Court")

    expect(oystercard.tapped_in_station).to eq([1, 2])
  end

  it "Returns the zones for the tapped out station" do
    oystercard.tap_out("Wimbledon")

    expect(oystercard.tapped_out_station).to eq([3])
  end

  it "Returns the max fare when you first tap in" do
    oystercard.tap_in("Wimbledon")

    expect(oystercard.fare).to eq(3.20)
  end

  context "Travelling through London" do
    it "Travelling in any three zones " do
      oystercard.tap_in("Holborn")
      oystercard.tap_out("Wimbledon")

      expect(oystercard.fare).to eq(3.20)
    end

    it "Travelling anywhere in zone 1" do
      oystercard.tap_in("Holborn")
      oystercard.tap_out("Earl's Court")

      oystercard.calculate_fare

      expect(oystercard.fare).to eq(2.50)
    end

    it "Travelling in any one zone outside zone 1" do
      oystercard.tap_in("Earl's Court")
      oystercard.tap_out("Hammersmith")

      oystercard.calculate_fare

      expect(oystercard.fare).to eq(2.00)
    end

    it "Travelling in any two zones including zone 1" do
      oystercard.tap_in("Holborn")
      oystercard.tap_out("Hammersmith")

      oystercard.calculate_fare

      expect(oystercard.fare).to eq(3.00)
    end

    it "Travelling in any two zones excluding zone 1" do
      oystercard.tap_in("Hammersmith")
      oystercard.tap_out("Wimbledon")

      oystercard.calculate_fare

      expect(oystercard.fare).to eq(2.25)
    end

    it "Charges the max fair if you dont tap out" do
      oystercard.tap_in("Hammersmith")

      oystercard.calculate_fare

      expect(oystercard.fare).to eq(3.20)
    end

    it "Returns the balance after the trip" do
      oystercard.tap_in("Hammersmith")
      oystercard.tap_out("Wimbledon")

      oystercard.calculate_fare

      expect(oystercard.balance).to eq(27.75)
    end
  end

end
