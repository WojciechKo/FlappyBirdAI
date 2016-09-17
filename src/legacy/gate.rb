class Gate
  attr_accessor :x, :y_rage

  def draw
    gate_up.draw(@x, y_rage.max + gate_up.height, 1)
    gate_down.draw(@x, y_rage.min, 1)
  end

  def move_by(distance)
    @x -= distance
  end

  private
  GATE_SIZE = 100
  OFFSET_Y = 25

  def initialize(window)
    @@window = window
    @window = window

    @x = @window.width
    min = @window.ground_height + OFFSET_Y
    max = @window.height - OFFSET_Y - GATE_SIZE
    bottom_of_gate = Random.new.rand(min..max)
    @y_rage = (bottom_of_gate..bottom_of_gate + GATE_SIZE)
  end

  def gate_up
    @@gate_up ||= Gosu::Image.new(@@window, 'media/wall_up.png', true)
  end

  def gate_down
    @@gate_down ||= Gosu::Image.new(@@window, 'media/wall_down.png', true)
  end

  def width
    @width ||= @wall_image.width
  end
end
