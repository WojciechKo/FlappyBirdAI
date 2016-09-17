module View
  class Ground
    def initialize(window)
      @window = window
      @ground_y = window.height - height
    end

    def draw
      ground_image.draw(0, ground_y, 1)
    end

    def height
      ground_image.height
    end

    private
    # magical number based on ground image
    # GROUND_PERIOD = 14

    attr_reader :window, :ground_y

    def ground_image
      @ground_image ||= Gosu::Image.new('media/ground.png')
    end
  end
end
