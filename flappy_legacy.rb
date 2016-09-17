require 'gosu'
require './lib/player'
require './lib/ground'
require './lib/gate'

class GameWindow < Gosu::Window

  attr_accessor :entities, :walls, :delta_time

  # Initialize the game
  def initialize
    super(288, 512, false)
    self.caption = "FlappyBirdAI"
    @game_on = false
    reset
  end

  def reset
    @delta_time = 0
    @last_time = 0
    @score = 0
    @ground = Background.new(self)
    @player = Bird.new(self)
    @gates = []
  end

  def font
    @font ||= Gosu::Font.new(self, 'Courier', 40)
  end

  def ground_height
    @ground.height
  end

  private

  # Update game for each loop occurence - standard gosu method
  def update
    @game_on ? move_game(2) : start_game_if_space_pressed
  end

  def move_game(distance)
    update_delta_time
    manage_gates
    @gates.each { |gate| gate.move_by(distance) }
    @ground.move_by(distance)
    @player.move_by(distance)

    @game_on = !@player.dead
  end

  def update_delta_time
    current_time = Gosu::milliseconds / 1000.0
    @delta_time = [current_time - @last_time, 0.25].min
    @last_time = current_time
  end

  def manage_gates
    delete_gate_if_needed
    create_gate_if_needed
  end

  def delete_gate_if_need
    # code here
  end

  def create_gate_if_needed
    if @gates.empty? || @gates.first.x
      gate = Gate.new(self)
    end

    @gates << gate if gate
  end

  def start_game_if_space_pressed
    if self.button_down?(Gosu::KbSpace)
      reset
      @game_on = true
    end
  end

  def draw
    background_image.draw(0, 0, 0)
    message_image.draw(width/2 - message_image.width/2, 50, 10) unless @game_on
    # draw the score
    font.draw(@score, 10, 10, 20)
    @ground.draw
    @gates.each { |wall| wall.draw }
    @player.draw
  end

  def sky_height
    background_image.height - self.ground_height
  end

  def background_image
    @background_image ||= Gosu::Image.new(self, "media/background.png", true)
  end

  def message_image
    @message_image ||= Gosu::Image.new(self, "media/message.png", true)
  end
end

window = GameWindow.new
window.show
