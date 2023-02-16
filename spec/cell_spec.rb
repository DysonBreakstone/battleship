require './lib/cell'
require './lib/ship'

RSpec.describe Cell do 

  let(:cell) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe '#initialize' do
    it 'exists' do
      expect(cell).to be_a(Cell)
    end

    it 'has attributes' do
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
    end
  end

  describe '#empty?' do
    it 'returns true if cell does not contain a ship' do
      expect(cell.empty?).to eq(true)
    end

    it 'returns false if cell contains a ship' do
      cell.place_ship(cruiser)

      expect(cell.empty?).to eq(false)
    end
  end

  describe '#place_ship' do
    it 'places a ship on the cell' do
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
    end
  end
end