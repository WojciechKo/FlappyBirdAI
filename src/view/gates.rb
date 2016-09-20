module View
  class Gates
    def draw(gates)
      gates.to_a.each do |gate|
        gate_up.draw(*gate_up_coords(gate))
        gate_down.draw(*gate_down_coords(gate))
      end
    end

    private

    def gate_up_coords(gate)
      [window.bird_start + gate.width_range.min,
       window.game_height - gate_up.height - gate.pass_range.max,
       0]
    end

    def gate_down_coords(gate)
      [window.bird_start + gate.width_range.min,
       window.game_height - gate.pass_range.min,
       0]
    end

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
