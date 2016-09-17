class Bird
  def initialize(altitude: 100)
    @altitude = altitude
    @y_speed = 0
  end

  def move(time)
    delta_speed = GRAVITY * time
    self.altitude = altitude + (@y_speed * time) + (delta_speed * time) * 2
    @y_speed = @y_speed + delta_speed
  end

  def jump
    @y_speed = 25
  end

  def width_range
    (0..WIDTH)
  end

  def height_range
    (altitude..altitude + HEIGHT)
  end

  attr_accessor :altitude

  private

  HEIGHT = 20
  WIDTH = 20
  GRAVITY = -13
end
