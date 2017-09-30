module Ai
  class Sonar
    def initialize(flappy_bird)
      @flappy_bird = flappy_bird
    end

    def scan
      gate = next_gate
      {
        end_of_gate: end_of_gate(gate),
        bottom_of_gate: bottom_of_gate(gate),
        gate_start: gate.width_range.min,
        gate_end: gate.width_range.max
      }
    end

    private

    attr_reader :flappy_bird

    def end_of_gate(gate)
      gate.width_range.max
    end

    def bottom_of_gate(gate)
      flappy_bird.bird.altitude - gate.pass_range.min
    end

    def next_gate
      gate_index = flappy_bird.gates.to_a.find_index do |gate|
        gate.width_range.max > 0
      end
      flappy_bird.gates.to_a[gate_index]
    end
  end
end
