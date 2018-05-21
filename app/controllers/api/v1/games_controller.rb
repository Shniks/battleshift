module Api
  module V1
    class GamesController < ApiController 
      before_action :find_game, only: [:show, :create]
      
      def show
        return render_400('Game does not exist') unless @game
        render_game
      end

      def create
        render json: Game.create_default(params[:opponent_email], api_key)
      end

      private

      def render_game
        render json: @game
      end
    end
  end
end
