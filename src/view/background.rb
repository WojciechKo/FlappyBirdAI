module View
  class Background
    def draw
      background_image.draw(0, 0, 0)
    end

    private

    def background_image
      @background_image ||= Gosu::Image.new('media/background.png')
    end

    def message_image
      @message_image ||= Gosu::Image.new('media/message.png')
    end
  end
end
