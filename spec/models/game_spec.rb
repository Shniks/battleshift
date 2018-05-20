require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:player_1_board) }
    it { is_expected.to validate_presence_of(:player_2_board) }
  end

  describe "Relationships" do
    it { is_expected.to belong_to :player_1 }
    it { is_expected.to belong_to :player_2 }
  end

  describe 'class methods' do
    describe '.create_default' do
      let(:headers) { { 'X-API-key': 'ez123' } }
      let(:params) { { opponent_email: 'SomeBody@once.com' } }
      let(:game) { Game.create_default(params, headers) }

      it 'creates a game with a 4x4 board' do
        size1 = game.player_1_board.board.size
        size2 = game.player_2_board.board.size

        expect(game.player_1_board).to be_a(Board)
        expect(game.player_2_board).to be_a(Board)
        expect(size1).to eq(4)
        expect(size2).to eq(4)
      end
    end
  end

  describe 'instance methods' do
    let(:headers) { { 'X-API-key': 'ez123' } }
    let(:params) { { opponent_email: 'SomeBody@once.com' } }
    let(:game) { Game.create_default(params, headers) }

    # describe '#invalid_turn?' do
    #   it 'checks for an invalid turn' do
    #     binding.pry
    #   end
    # end

    describe '#current_turn' do
      it 'switches turns between player 1 and player 2' do
        game.current_turn = 0

        expect(game.current_turn).to eq('challenger')

        game.current_turn = 1

        expect(game.current_turn).to eq('opponent')
      end
    end
  end
end
