class Ground
  def draw
    ground_image.draw(ground_x, ground_y, 5)
  end

  def move_by(distance)
    @ground_x = rewind_image? ? 0 : ground_x - distance
  end

  def height
    ground_image.height
  end

  private

  attr_reader :ground_x, :window

  def initialize(window)
    @window = window
    @ground_x = 0
  end

  def ground_y
    @ground_y ||= window.height - ground_image.height
  end

  def rewind_image?
    ground_x + (ground_image.width / 2) <= 0
  end

  def ground_image
    @ground_image ||= Gosu::Image.new(window, 'media/ground.png', true)
  end
end
