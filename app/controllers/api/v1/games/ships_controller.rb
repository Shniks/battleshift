module Api
  module V1
    module Games
      class ShipsController < ApiController 
        before_action :find_game, only: [:index]
        before_action :set_board, only: [:index]

        def index
          ship.place(params[:start_space], params[:end_space] )
          ship_placer.run
          @game.save!
          render json: @game, message: message
        end

        private

          def ship_placer
            ShipPlacer.new( board: @board,
                            ship: ship,
                            start_space: params[:start_space],
                            end_space: params[:end_space] )
          end

          def message
            ship_placer.message
          end

          def ship
            Ship.new(params[:ship_size].to_i)
          end

          def set_board
            if api_key == @game.p1.api_key
              @board = @game.p1_board
            else
              @board = @game.p2_board
            end
          end
      end
    end
  end
end
