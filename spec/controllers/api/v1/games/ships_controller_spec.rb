require 'rails_helper'

RSpec.describe Api::V1::Games::ShipsController, type: :controller do
  describe 'endpoints' do
    describe 'POST index' do
      let(:game) { create(:game) }
      let(:params) { { game_id: game.id, start_space: 'A1', end_space: 'B1', ship_size: 2 } }

      before(:each) do
        @request.headers['X-API-key'] = game.p1.api_key
      end

      it 'has a successfull response' do
        post :index, params: params

        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/json')
      end

      it 'places a ship' do
        raw_board = Game.last.p1_board.board.flatten.map{ |space| space.values.first.contents }
        expect(raw_board.compact).to be_empty

        post :index, params: params

        raw_board = Game.last.p1_board.board.flatten.map{ |space| space.values.first.contents }
        expect(raw_board.compact).to_not be_empty
      end
    end
  end
end
