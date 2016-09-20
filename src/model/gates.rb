require 'byebug'
class Gates
  GATE_SPAN = 200

  def initialize(height, gate_width)
    @height = height
    @gate_width = gate_width
    @gates = [Gate.new(height, gate_width, GATE_SPAN)]
  end

  def move(time)
    @gates.each do |gate|
      gate.move(time)
    end
    delete_gate
    create_gate
  end

  def to_a
    @gates
  end

  private
  attr_reader :height, :gate_width

  def delete_gate
    @gates.shift if @gates.first.x < -GATE_SPAN
  end

  def create_gate
    if @gates.last.x < GATE_SPAN
      @gates << Gate.new(height, gate_width, @gates.last.x + GATE_SPAN)
    end
  end
end

class Gate
  GATE_SIZE = 100
  OFFSET_Y = 50

  attr_accessor :x

  def initialize(height, width, distance)
    @height = height
    @width = width
    @x = distance

    max = height - offset - GATE_SIZE
    @bottom_of_gate = Random.new.rand(offset..max)
  end

  def move(time)
    new_x = self.x - time/5
    self.x = new_x
  end

  def width_range
    (x..x + @width)
  end

  def pass_range
    (@bottom_of_gate..@bottom_of_gate + GATE_SIZE)
  end

  private

  def offset
    @offset ||= (@height * 0.1).to_i
  end
end