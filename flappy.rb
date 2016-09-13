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

  def font
    @font ||= Gosu::Font.new(self, 'Courier', 40)
  end

  # Return the height of ground
  # @return [integer]
  def ground_height
    @ground.height
  end

  private

  # Reset all elements
  def reset
    @delta_time = 0
    @last_time = 0
    @score = 0
    @ground = Ground.new(self)
    @player = Player.new(self)
    @gates = []
  end

  # Update game for each loop occurence - standard gosu method
  def update
    if @game_on
      move_game(2)
    else
      start_game_if_space_pressed
    end
  end

  def move_game(distance)
    update_delta_time
    @gates << Gate.new(self) if @gates.empty?
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

  # Compute height of sky
  # @return [integer] the height of sky
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
