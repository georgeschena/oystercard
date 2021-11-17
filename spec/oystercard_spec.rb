require "oystercard"
require "stations"

describe Oystercard do
  it "allows a user to add money to their oyster card" do
    oystercard = Oystercard.new(30)
    expect(oystercard.balance).to eq(30)
  end

  it "Returns the zones for the tapped in station" do
    oystercard = Oystercard.new(30)
    oystercard.tap_in("Earl's Court")
    expect(oystercard.tapped_in_station).to eq([1, 2])
  end

  it "Returns the zones for the tapped out station" do
    oystercard = Oystercard.new(30)
    oystercard.tap_out("Wimbledon")
    expect(oystercard.tapped_out_station).to eq([3])
  end

end
