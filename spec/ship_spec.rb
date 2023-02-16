require './lib/ship'

RSpec.describe Ship do
  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe "#Initialize" do

    it "exists" do
      expect(cruiser).to be_a(Ship)
    end

    it "has attributes" do
      expect(cruiser.length).to eq(3)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.health).to eq(3)
    end
  end


end