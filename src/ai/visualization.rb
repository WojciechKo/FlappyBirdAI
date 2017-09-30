require_relative '../view/main'
require_relative 'controller'

module Ai
  class Visualization
    def initialize
      @window = View::Main.new
      @controller = Controller.new(@window)

      class << @window
        alias :old_update :update

        def controller=(controller)
          @controller = controller
          @score = []
        end

        def update
          action = @controller.make_action
          @score << flappy_bird.score
          old_update
          unless action == :reset
            @controller.store_decision
          else
            puts @score.max
            @score = []
          end
        end
      end

      @window.controller = @controller
      @window.restart
    end

    def start
      @window.show
    end
  end
end

Ai::Visualization.new.start