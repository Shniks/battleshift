require 'rails_helper'

describe TurnProcessor do
  player_1_board = Board.new(4)
  player_2_board = Board.new(4)
  sm_ship = Ship.new(length: 2)
  ShipPlacer.new(board: player_2_board,
                 ship: sm_ship,
                 start_space: 'B1',
                 end_space: 'C1').run
  game = create(:game,
                player_1: player_1,
                player_2: player_2,
                player_1_board: player_1_board,
                player_2_board: player_2_board)

  turn_processor =  TurnProcessor.new(game, 'A1') }

  context 'attributes' do
    it 'has a status' do

      expect(subject.status).to eq(200)
    end
  end

  # context 'instance methods' do
  #   describe '#run!' do
  #     it 'attacks the opponent and returns the current status of the game' do
  #       player_1 = create(:user)
  #       player_2 = create(:user)
  #       let(:sm_ship) { double(length: 2) }
  #
  #       allow_any_instance_of(Shooter).to receive(:fire!).and_return('Miss')
  #       allow_any_instance_of(Shooter).to receive(:message).and_return(nil)
  #       allow(board).to receive(:conquered?).and_return(false)
  #
  #       expect(game.current_turn).to eq('player_1')
  #
  #       subject.run!
  #
  #       expect(game.current_turn).to eq('player_2')
  #       expect(subject.message).to eq('Your shot resulted in a Miss.')
  #     end
  #
  #     it 'raises an error when a player performs an invalid move' do
  #       let(:sm_ship) { double(length: 2) }
  #       player_1 = create(:user)
  #       player_2 = create(:user)
  #       game.winner = ('jane@gmail.com')
  #
  #       subject.run!
  #
  #       expect(subject.message).to eq('Invalid move. Game over.')
  #       expect(subject.status).to eq(400)
  #     end
  #   end
  #
  #   describe '#message' do
  #     it 'returns the result of the hit and if the battleship is sunk or the game is over' do
  #       let(:sm_ship) { double(length: 2) }
  #       player_1 = create(:user)
  #       player_2 = create(:user)
  #       allow_any_instance_of(Shooter).to receive(:fire!).and_return('Hit')
  #       allow_any_instance_of(Shooter).to receive(:message).and_return('Battleship sunk.')
  #       allow(board).to receive(:conquered?).and_return(false)
  #
  #       subject.run!
  #
  #       expect(subject.message).to eq('Your shot resulted in a Hit. Battleship sunk.')
  #     end
  #   end
  # end
end
