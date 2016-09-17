require 'gosu'

require_relative 'background'
require_relative 'bird'
# require_relative 'gates'

require_relative '../../src/model/flappy_bird'

module View
  class Main < Gosu::Window
    attr_accessor :flappy_bird

    def initialize(flappy_bird: FlappyBird.new)
      super(288, 512, false)
      self.caption = "FlappyBirdAI"
      @time = 0

      @flappy_bird = flappy_bird
    end

    def draw
      background.draw
      # gates.draw(flappy_bird.gates)
      bird.draw(flappy_bird.bird)
    end

    def background
      @background ||= Background.new(self)
    end

    def gates
      @gates ||= Gates.new(self)
    end

    def bird
      @bird ||= Bird.new(self)
    end

    def update
      modify_game_state(update_interval / 100.0)
    end

    def modify_game_state(delta_time)
      if @game_on
        flappy_bird.jump if space_pressed?
        @game_on = flappy_bird.move(delta_time)
      elsif space_pressed?
        flappy_bird.init
        @game_on = true
      end
    end

    def space_pressed?
      return @space_pressed = false unless button_down?(Gosu::KbSpace)

      new_press = !@space_pressed
      @space_pressed = true
      new_press
    end
  end
end
