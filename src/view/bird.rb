module View
  class Bird
    def initialize(window)
      @window = window
    end

    def draw(bird)
      image.draw_rot(window.width / 4,
                     y_cord(bird),
                     1,
                     0)
    end

    private

    attr_reader :window

    def image
      images[(Gosu.milliseconds/100) % 3]
    end

    def y_cord(bird)
      window.ground_y - images.first.height/2 - bird.altitude
    end

    def images
      @images ||= ['media/flappy-1.png', 'media/flappy-2.png', 'media/flappy-3.png'].map do |path|
        Gosu::Image.new(path)
      end
    end
  end
end
