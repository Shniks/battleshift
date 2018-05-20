require 'rails_helper'

describe Shooter do
  context 'Instance methods' do
    describe '#fire!' do
      it 'doesn\'t allow shooting invalid coordinates' do
        shooter = Shooter.new(board: Board.new(4), target: 'A7')
        
        expect{ shooter.fire! }.to raise_error
      end
    end
  end
end
