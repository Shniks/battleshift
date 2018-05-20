require 'rails_helper'

describe 'As a player' do
  describe 'When a shot is fired' do
    it 'a text message is sent to me about it' do
      player_1 = create(:user)
      player_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2)
      ShipPlacer.new(board: player_2_board,
                     ship: sm_ship,
                     start_space: 'B1',
                     end_space: 'C1').run
      game = create(:game,
                    player_1: player_1,
                    player_2: player_2,
                    player_1_board: player_1_board,
                    player_2_board: player_2_board)

      headers = { 'CONTENT_TYPE' => 'application/json', 'X-API-key' => player_1.api_key }
      json_payload = {target: 'A1'}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expected_text = 'Shots have been fired!'
      twilio_text = TwilioTextMessenger.new(expected_text).call

      expect(twilio_text.body).to include('BattleShift: Your opponent has fired a shot. Fire back!')
      expect(twilio_text.from).to eq('+13033098898')
    end
  end
end
