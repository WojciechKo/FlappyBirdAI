require 'active_support/core_ext/range/overlaps'
require 'gosu'
require_relative 'bird'
require_relative 'gates'

class FlappyBird

  attr_reader :score

  def initialize(height)
    @height = height
    init
  end

  def init
    @bird = Bird.new
    @gates = Gates.new(height)
    @score = 0
  end

  def move(time)
    @score = @score + time
    bird.move(time)
    gates.move(time)
    !dead?
  end

  def jump
    bird.jump
  end

  def dead?
    hit_ground? || hit_gate?
  end

  attr_reader :bird, :gates, :height

  private

  def hit_ground?
    bird.altitude <= 0
  end

  def hit_gate?
    gates.to_a
      .select { |gate| gate.width_range.overlaps?(bird.width_range) }
      .any? { |gate| !contains?(gate.pass_range, bird.height_range) }
  end

  def contains?(container, containee)
    container.min <= containee.min && container.max >= containee.max
  end

  def print_gates(gates)
    puts "Bird: #{bird.width_range.inspect}"
    gates.to_a.each do |g|
      puts "Gate: #{g.width_range.inspect}"
    end
  end
end
