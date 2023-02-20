require 'spec_helper'

RSpec.describe Game do

  let(:game) { Game.new }

  describe '#initialize' do
    it 'exists' do
      expect(game).to be_a(Game)
    end

    it 'has attributes' do
      expect(game.player_board).to be_a(Board)
      expect(game.cpu_board).to be_a(Board)
      expect(game.player_cruiser).to be_a(Ship)
      expect(game.player_submarine).to be_a(Ship)
      expect(game.cpu_cruiser).to be_a(Ship)
      expect(game.cpu_submarine).to be_a(Ship)
      expect(game.cpu_guess_pool).to be_a(Array)
      expect(game.player_guess_pool).to be_a(Array)
    end
  end
end