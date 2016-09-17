class Bird
  def jump
    @y_speed = -25
  end

  def move(time)
    # puts "move time: #{time}"
    delta_speed = GRAVITY * time
    # puts "y_speed: #{@y_speed}, DELTA: #{delta_speed}"
    self.altitude = altitude + (@y_speed * time) - (delta_speed * time) *2
    @y_speed = @y_speed + delta_speed
  end

  def draw
  end

  def width_range
    (0..WIDTH)
  end

  def height_range
    (altitude..altitude + HEIGHT)
  end

  attr_accessor :altitude

  HEIGHT = 20
  WIDTH = 20

  private

  GRAVITY = 13

  def initialize(altitude: 100)
    @altitude = altitude
    @y_speed = 0
  end

  class Renderer
    def draw(bird)
      images.first.draw_rot(@window.width / 4, bird.altitude + Bird::HEIGHT/2, 1, 0)
    end

    private

    def initialize(window)
      @window = window
    end

    def images
      @images ||= ['media/flappy-1.png', 'media/flappy-2.png', 'media/flappy-3.png'].map do |path|
        Gosu::Image.new(path)
      end
    end
  end
end