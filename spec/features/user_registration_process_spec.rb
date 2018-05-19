require 'rails_helper'

describe 'user registration process' do
  let(:user) { create(:user, :unregistered) }

  context 'a non-activated user' do
    context 'confirms email activiation' do
      scenario 'they are successfully registered' do
        welcome_message  = 'Thank you! Your account is now activated.'

        visit "/users/activation?key=#{user.api_key}" 

        expect(current_path).to eq(dashboard_path)
        expect(User.first.activated?).to be_truthy 
      end
    end
  end
end
