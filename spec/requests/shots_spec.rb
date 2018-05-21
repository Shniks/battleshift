require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2) }
    let(:game) { create(:game) }

    it "updates the message and board with a hit" do
      game = create(:game)
      ShipPlacer.new(board: game.p1_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run
      game.save!

      headers = { "CONTENT_TYPE" => "application/json", 'X-API-key' => player_2.api_key }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit."
      player_2_targeted_space = game[:player_1_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      game = create(:game)

      headers = { "CONTENT_TYPE" => "application/json", 'X-API-key' => game.p2.api_key }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss."
      player_2_targeted_space = game[:player_1_board][:rows].first[:data].first[:status]

      expect(game[:message]).to include expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      p1_board = Board.new(1)
      p2_board = Board.new(1)
      game = create(:game, player_1_board: p1_board, player_2_board: p2_board)

      headers = { "CONTENT_TYPE" => "application/json", 'X-API-key' => game.p2.api_key }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates."
    end

  end
end
