require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Board do

  let(:board) { Board.new }

  describe '#initialize' do
    it 'exists' do
      expect(board).to be_a(Board)
    end

    it 'has attributes' do
      expect(board.cells.values).to all(be_a(Cell))
      expect(board.valid_coordinate).to eq(board.cells.keys)
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
end