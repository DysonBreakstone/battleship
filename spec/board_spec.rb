require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Board do

  let(:board) { Board.new }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:submarine) { Ship.new("Submarine", 2) }

  describe '#initialize' do
    it 'exists' do
      expect(board).to be_a(Board)
    end

    it 'has attributes' do
      expect(board.cells.values).to all(be_a(Cell))
      expect(board.valid_coordinate).to eq(board.cells.values)
    end

  end

  describe "valid_coordinate" do
    it "determines whether coordinate is on the board" do
      expect(board.valid_coordinate?("A1")).to be(true)
      expect(board.valid_coordinate?("D4")).to be(true)
      expect(board.valid_coordinate?("A5")).to be(false)
      expect(board.valid_coordinate?("E1")).to be(false)
      expect(board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe '#valid_placement?' do
    it 'checks that the coordinates in the array are the same length' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)
      # require 'pry'; binding.pry
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    end

    it 'checks that the coordinates are consecutive' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    end

    it 'checks to make sure the coordinates are not diagonal' do
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    end

    it 'returns true if the placement is valid' do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
    end

    it 'returns false if ships are overlapping' do
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be(false)
    end
  end

  describe "#place" do
    it "can place ships on cells" do
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cell_3.ship)
    end
  end
  
  describe "#render" do
    it "renders without optional argument" do
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render). to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it "renders with optional argument" do
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it "renders different cell states" do
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_4 = board.cells["A4"]
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1.fire_upon
      cell_2.fire_upon
      cell_4.fire_upon

      expect(board.render(true)).to eq("  1 2 3 4 \nA H H S M \nB . . . . \nC . . . . \nD . . . . \n")
      
      cell_3.fire_upon

      expect(board.render(true)).to eq("  1 2 3 4 \nA X X X M \nB . . . . \nC . . . . \nD . . . . \n")
      expect(cruiser.health).to eq(0)
    end
  end

end