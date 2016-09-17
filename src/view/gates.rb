module View
  class Gates
    def draw(gates)

    end

    private

    attr_reader :window

    def initialize(window)
      @window = window
    end

    def gate_up
      @gate_up ||= Gosu::Image.new(window, 'media/wall_up.png', true)
    end

    def gate_down
      @gate_down ||= Gosu::Image.new(window, 'media/wall_down.png', true)
    end
  end
end
