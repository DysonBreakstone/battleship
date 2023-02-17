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
  end
end