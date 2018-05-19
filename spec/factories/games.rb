FactoryBot.define do
  factory :game do
    player_1 { create(:user) }
    player_2 { create(:user_2) }
    player_1_board "You should add a board object"
    player_2_board "You should add a board object"
    winner nil
    player_1_turns 0
    player_2_turns 0
    current_turn "challenger"
  end
end
