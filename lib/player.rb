require 'byebug'

class Player
  attr_accessor :player_x, :player_y, :dead

  def draw
    player_image.draw_rot(@player_x, @player_y, 1, @angle)
  end

  def move_by(distance)
    @dead = (@player_y >= ground_y - player_image.height/2)
    @dead ? bird_fall : bird_fly
  end

  def collision?(other)
    @player_y + player_image.height / 2 > other.y &&
      @player_y - player_image.height / 2 < other.y + other.height &&
      @player_x + player_image.width / 2 > other.x &&
      @player_x - player_image.width / 2 < other.x + other.width
  end

  def fly_up

  end

  private

  GRAVITY = 100
  JUMP_TIME = 0.3
  JUMP_POWER = 250
  INCREASE_GRAVITY = 10

  def initialize(window)
    @window = window

    @velocityY = 0
    @gravity = 50

    @space = false
    @space_before = false

    @jump = false
    @jump_max = 0.3
    @jump_start = 0

    @dead = false

    @player_x = @window.width / 4
    @player_y = @window.height / 2
    @angle = 0
  end

  def images
    @images ||= ['media/flappy-1.png', 'media/flappy-2.png', 'media/flappy-3.png'].map do |path|
      Gosu::Image.new(@window, path, true)
    end
  end

  def player_image
    image_index = (Gosu::milliseconds / 1000) % 3
    images[image_index]
  end

  def ground_y
    @window.height - @window.ground_height
  end

  def user_hit_space?
    @window.button_down?(Gosu::KbSpace)
  end

  def bird_fall
    if @player_y < ground_y - player_image.height/2
      @gravity += INCREASE_GRAVITY
      @angle += 25
      @angle = [@angle, 90].min
      @player_y += @gravity * @window.delta_time
    else
      @player_y = ground_y - player_image.height/2
    end
  end

  def bird_fly
    @space = user_hit_space?
    @jump_start = Gosu::milliseconds / 1000.0 if @space && !@space_before
    update_jump_params if @jump_start > 0
    @space_before = @space
    @player_y += @velocityY * @window.delta_time
    @gravity += INCREASE_GRAVITY
    @angle += 0.5
    @angle = [@angle, 90].min
    @player_y += @gravity * @window.delta_time
  end

  def update_jump_params
    @gravity = GRAVITY
    if ((Gosu::milliseconds / 1000.0) - @jump_start) > JUMP_TIME
      @jump_start = 0
    else
      @velocityY = -JUMP_POWER
      @angle = -45
      @angle = -22 if ((Gosu::milliseconds / 1000.0) - @jump_start) > JUMP_TIME / 3
      @angle = 0 if ((Gosu::milliseconds / 1000.0) - @jump_start) > (JUMP_TIME / 3)*2
    end
  end
end
