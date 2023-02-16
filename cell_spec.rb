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
end