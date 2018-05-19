require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do

  describe 'endpoints' do
    describe 'GET show' do
      let(:game) { create(:game) }

      it 'renders a game successfully' do
        get :show, params: { id: game.id } 

        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a 400 if a game cannot be found' do
        get :show, params: { id: -1 }

        expect(response.status).to eq(400)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq('Game does not exist')
      end
    end

    describe 'POST create' do
      let(:challenger) { create(:user) }
      let(:opponent) { create(:user) }

      it 'creates a new game' do
        expect(Game.all.size).to eq(0)

        @request.headers['X-API-key']  = challenger.api_key 
        post :create, params: { opponent_email: opponent.email }

        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/json')
        expect(Game.all.size).to eq(1)
      end
    end
  end
end
