require './lib/cell'
require './lib/ship'

RSpec.describe Cell do 

  let(:cell_1) { Cell.new("B4") }
  let(:cell_2) { Cell.new("C3") }
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

  describe '#fired_upon?' do
    it 'returns false when #fire_upon method has not been called' do
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)
    end

    it 'returns true when #fire_upon method has been called' do
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.fired_upon?).to eq(true)
    end
  end

  describe 'fire_upon' do
    it 'reduces health of ship' do
      cell.place_ship(cruiser)
      
      expect(cruiser.health).to eq(3)
      
      cell.fire_upon

      expect(cruiser.health).to eq(2)
    end

  end

  describe '#render' do
    it 'can render specific string representation of what has happened based on fired_upon' do
      expect(cell_1.render).to eq('.')
      
      cell_1.fire_upon
      expect(cell_1.render).to eq('M')
      
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq('.')
      expect(cell_2.render(true)).to eq('S')

      cell_2.fire_upon
      expect(cell_2.render).to eq('H')
      
      2.times do cruiser.hit
      end
      expect(cell_2.render).to eq('X')
      expect(cruiser.health).to eq(0)
      expect(cruiser.sunk?).to eq(true)
    end
  end
end
