require 'rails_helper'

RSpec.describe Users::ActivationController, type: :controller do
  describe 'endpoints' do
    describe 'PATCH update' do
      let(:user) { create(:user, :unregistered) }

      it 'activates the user' do
        patch :update, params: { key: user.api_key }
        user = User.last

        expect(user.activated?).to be_truthy
      end

      it 'redirects to dashboard' do
        patch :update, params: { key: user.api_key }

        expect(response).to redirect_to(:dashboard)
        expect(session[:user_id]).to eq(user.id)
      end
    end
  end
end
