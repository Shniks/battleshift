require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do

  describe 'endpoints' do
    let(:game) { create(:game) }

    describe '#show' do
      it 'renders a game successfully' do
        binding.pry
      end
    end
  end
end
