require './lib/ship'

RSpec.describe Ship do

  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe "#initialize" do

    it "exists" do
      expect(cruiser).to be_a(Ship)
    end

    it "has attributes" do
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end

  describe "#sunk?" do

    it "appears false if not sunk" do
      expect(cruiser.sunk?).to eq(false)
      expect(cruiser.health).to eq(3)
    end

    it "appears true after sunk" do
      3.times do cruiser.hit
      end
      expect(cruiser.health).to eq(0)
      expect(cruiser.sunk?).to eq(true)
    end
  end

    describe "#hit" do
      it "detracts from health attribute" do
        cruiser.hit
        expect(cruiser.health).to eq(2)
        cruiser.hit
        expect(cruiser.health).to eq(1)
        cruiser.hit
        expect(cruiser.health).to eq(0)
      end
    end
end
