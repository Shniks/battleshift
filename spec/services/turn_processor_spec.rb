require 'rails_helper'

describe TurnProcessor do
  it 'can receive methods' do
    turnprocessor = spy(TurnProcessor)
    game = create(:game)
    turnprocessor.new(game, 'A1')
    turnprocessor.run!
    turnprocessor.message

    expect(turnprocessor).to have_received(:run!).once
    expect(turnprocessor).to have_received(:message).once
  end
end
