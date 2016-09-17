require 'active_support/core_ext/range/overlaps'
require 'gosu'
require_relative 'bird'
require_relative 'gates'
require_relative 'background'

class FlappyBird
  def jump
    bird.jump
  end

  def move(time)
    @bird.move(time)
    @gates.move(time)
    !dead?
  end

  attr_reader :bird, :gates

  private

  def initialize(bird: Bird.new, gates: Gates.new)
    @bird = bird
    @gates = gates
  end

  def dead?
    hit_ground? || hit_gate?
  end

  def hit_ground?
    bird.altitude <= 0
  end

  def hit_gate?
    gates
      .select { |gate| gate.width_range.overlaps?(bird.width_range) }
      .any? { |gate| !gate.pass_range.overlaps?(bird.height_range) }
  end

  class Renderer < Gosu::Window
    def update
      @last_time ||= Gosu::milliseconds()
      delta_time = Gosu::milliseconds() - @last_time

      modify_game_state(delta_time / 100.0 )

      @last_time = Gosu::milliseconds()
    end

    def draw
      @background.draw
      @bird_renderer.draw(flappy_bird.bird)
    end

    def modify_game_state(delta_time)
      if @game_on
        flappy_bird.jump if button_down?(Gosu::KbSpace)
      elsif button_down?(Gosu::KbSpace)
        @game_on = true
        flappy_bird.jump
      end
      handle_game_on(delta_time)
    end

    def handle_game_on(delta_time)
      @game_on = !flappy_bird.move(delta_time)
    end

    attr_accessor :flappy_bird

    private

    def initialize(flappy_bird: FlappyBird.new)
      super(288, 512, false)
      self.caption = "FlappyBirdAI"

      @time = 0
      @flappy_bird = flappy_bird
      @bird_renderer = Bird::Renderer.new(self)
      @background = Background.new(self)
    end
  end
end
