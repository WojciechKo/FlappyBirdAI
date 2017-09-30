require 'gosu'

require_relative 'background'
require_relative 'ground'
require_relative 'gates'
require_relative 'bird'
require_relative 'sonar'

require_relative '../model/flappy_bird'
require_relative '../ai/sonar'

module View
  class Main < Gosu::Window
    attr_accessor :flappy_bird

    def initialize
      super(288, 512, false)
      self.caption = 'FlappyBirdAI'

      @flappy_bird = FlappyBird.new(game_height)
      @ai_sonar = ::Ai::Sonar.new(@flappy_bird)
    end

    def draw
      background.draw
      ground.draw
      gates.draw(flappy_bird.gates)
      bird.draw(flappy_bird.bird)
      sonar_view.draw(@ai_sonar)
    end

    def background
      @background ||= Background.new
    end

    def ground
      @ground ||= Ground.new(self)
    end

    def gates
      @gates ||= Gates.new(self)
    end

    def bird
      @bird ||= Bird.new(self)
    end

    def sonar_view
      @sonar ||= ::View::Sonar.new(self)
    end

    def update
      delta_time = update_interval.to_i / 2

      modify_game_state
      move_game(delta_time)
    end

    def game_height
      height - ground.height
    end

    def bird_start
      width / 4
    end

    def move_game(delta_time)
      @game_on = flappy_bird.move(delta_time) if @game_on
    end

    def restart
      flappy_bird.init
      flappy_bird.jump
      @game_on = true
    end

    private

    def modify_game_state
      if space_pressed?
        @game_on ? flappy_bird.jump : restart
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
