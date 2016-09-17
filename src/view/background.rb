module View
  class Background
    def draw
      background_image.draw(0, 0, 0)
      ground_image.draw(0, ground_y, 1)
    end

    private

    # magical number based on ground image
    # GROUND_PERIOD = 14

    attr_reader :ground_x, :ground_y

    def initialize(window)
      @window = window
      @ground_y = window.height - ground_image.height
    end

    def background_image
      @background_image ||= Gosu::Image.new('media/background.png')
    end

    def ground_image
      @ground_image ||= Gosu::Image.new('media/ground.png')
    end

    def message_image
      @message_image ||= Gosu::Image.new('media/message.png')
    end
  end
end
