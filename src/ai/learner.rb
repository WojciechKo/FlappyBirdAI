module Ai
  class Player
    def initialize
      @flappy_bird = FlappyBird.new
      @controller = Controller.new
    end
  end
end
