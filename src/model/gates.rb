require 'byebug'
class Gates
  GATE_SPAN = 200

  def initialize(height)
    @height = height
    @rand = Random.new#(123)
    @gates = [Gate.new(height, GATE_SPAN, @rand)]
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
  attr_reader :height

  def delete_gate
    @gates.shift if @gates.first.x < -GATE_SPAN
  end

  def create_gate
    if @gates.last.x < GATE_SPAN
      @gates << Gate.new(height, @gates.last.x + GATE_SPAN, @rand)
    end
  end
end

class Gate
  WIDTH = 52

  GATE_SIZE = 100
  OFFSET_Y = 50

  attr_accessor :x

  def initialize(height, distance, rand)
    @height = height
    @x = distance

    max = height - offset - GATE_SIZE
    @bottom_of_gate = rand.rand(offset..max)
  end

  def move(time)
    new_x = self.x - time/5
    self.x = new_x
  end

  def width_range
    (x...x + WIDTH)
  end

  def pass_range
    (@bottom_of_gate...@bottom_of_gate + GATE_SIZE)
  end

  private

  def offset
    @offset ||= (@height * 0.1).to_i
  end
end