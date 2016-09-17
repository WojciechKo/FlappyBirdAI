module View
  class Bird
    def draw(bird)
      images.first.draw_rot(window.width / 4,
                            bird.altitude + bird.height_range.size/2,
                            1,
                            0)
    end

    private

    attr_reader :window

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
