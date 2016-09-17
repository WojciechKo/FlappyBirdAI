require 'active_support/core_ext/range/overlaps'
require 'gosu'
require_relative 'bird'
require_relative 'gates'

class FlappyBird
  def initialize
    init
  end

  def init
    @bird = Bird.new
    @gates = Gates.new
  end

  def move(time)
    bird.move(time)
    gates.move(time)
    !dead?
  end

  def jump
    bird.jump
  end

  attr_reader :bird, :gates

  private

  def dead?
    hit_ground? || hit_gate?
  end

  def hit_ground?
    bird.altitude <= 0
  end

  def hit_gate?
    gates
      .select { |gate| gate.width_range.overlaps?(bird.width_range) }
      .any? { |gate| !gate.pass_range.overlaps?(bird.height_range) }
  end
end
