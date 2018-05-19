class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def run!
    begin
      attack_opponent
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    game_cycle(result)
  end

  def result
    board = opponent.board if game.current_turn == 'computer'
    board = player.board if game.current_turn == 'challenger'
    Shooter.fire!(board: board, target: target)
  end

  def game_cycle(result)
    game.cycle_turn
    game_over
    messages(result)
    game.player_1_turns += 1
  end

  def messages(result)
    @messages << "Your shot resulted in a #{result}."
    @messages <<  game_over_message if game_over_message
  end

  def game_over
    if player_1_loss? || player_2_loss?
      game_over_message
      game_winner
    end
  end

  def game_over_message
    'Game over.'
  end

  def game_winner
    game.winner = @winner_email
  end

  def player_1_loss?
    @winner_email = game.player_2.email
    game.p1_board.board.flatten.map{|x| x.flatten[1]}.map(&:contents).compact.map(&:is_sunk?).select{|x| x == true}.size >= 5
  end

  def player_2_loss?
    @winner_email = game.player_1.email
    game.p2_board.board.flatten.map{|x| x.flatten[1]}.map(&:contents).compact.map(&:is_sunk?).select{|x| x == true}.size >= 5
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end
end
