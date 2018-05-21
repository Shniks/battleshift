require 'rails_helper'

RSpec.describe Api::V1::Games::ShotsController, type: :controller do

  describe 'endpoints' do
    describe 'POST create' do
      let(:game) { create(:game) }

      it 'is successfull with everything' do
        @request.headers['X-API-key'] = game.p2.api_key
        params = { target: 'A1',
                   game_id: game.id,
                   shot: { target: 'A1' }
                 }
        post :create, params: params

        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a 401 if there is not a user' do
        params = { target: 'A1',
                   game_id: game.id,
                   shot: { target: 'A1' }
                 }
        post :create, params: params

        message = JSON.parse(response.body)['message']

        expect(response.status).to eq(401)
        expect(response.content_type).to eq('application/json')
        expect(message).to eq('Unauthorized')
      end

      it 'renders a 400 if a user tries to take more than 1 turn' do
        @request.headers['X-API-key'] = game.p2.api_key
        params = { target: 'A1',
                   game_id: game.id,
                   shot: { target: 'A1' }
                 }
        post :create, params: params
        post :create, params: params

        message = JSON.parse(response.body)['message']

        expect(response.status).to eq(400)
        expect(response.content_type).to eq('application/json')
        expect(message).to eq("Invalid move. It's your opponent's turn")
      end

      it 'renders a 400 if a player targets invalid coordinates' do
        @request.headers['X-API-key'] = game.p2.api_key
        params = { target: 'Z9',
                   game_id: game.id,
                   shot: { target: 'Z9' }
                 }
        post :create, params: params

        message = JSON.parse(response.body)['message']
        
        expect(response.status).to eq(400)
        expect(response.content_type).to eq('application/json')
        expect(message).to eq('Invalid coordinates.')
      end

      it 'renders a 400 if the game is over' do
        @request.headers['X-API-key'] = game.p2.api_key
        game.winner = game.p1.email
        game.save!
        params = { target: 'A1',
                   game_id: game.id,
                   shot: { target: 'A1' }
                 }
        post :create, params: params

        message = JSON.parse(response.body)['message']

        expect(response.status).to eq(400)
        expect(response.content_type).to eq('application/json')
        expect(message).to eq('Invalid move. Game over.')
      end
    end
  end

end
