require 'rails_helper'

describe Ship do
  subject { Ship.new(5) }

  it "Initializes with attributes" do
    expect(subject.length).to eq(5)
    expect(subject.damage).to eq(0)
    expect(subject.start_space).to eq(nil)
    expect(subject.end_space).to eq(nil)
  end

  describe "Instance_methods" do
    context "#attack!" do
      it "can increase ship damage" do
        subject.attack!

        expect(subject.damage).to eq(1)

        subject.attack!
        subject.attack!

        expect(subject.damage).to eq(3)
      end
    end

    context "#is_sunk" do
      it "will return true if the damage is equal to the length" do
        expect(subject.is_sunk?).to eq(false)

        subject.attack!
        subject.attack!

        expect(subject.is_sunk?).to eq(false)

        subject.attack!
        subject.attack!
        subject.attack!

        expect(subject.is_sunk?).to eq(true)
      end
    end
  end
end
