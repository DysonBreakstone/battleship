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
    end
  end
end