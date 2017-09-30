require 'pp'
require 'byebug'

State = Struct.new(:bottom_distance, :next_distance, :live)

module Ai
  class Controller
    GAMMA = 0.7

    def initialize(window)
      @window = window
      @sonar = Sonar.new(@window.flappy_bird)
      @q = {}
      @knowlade_count = 0
    end

    def make_action
      if @window.flappy_bird.dead?
        @window.restart
        :reset
      else
        @state_before_action = state
        @action = decide(@state_before_action)
        if @action == :jump
          @window.flappy_bird.jump
        end
      end
    end

    def store_decision
      after_state = state

      reward = @window.flappy_bird.dead? ? -1_000 : 1

      q_after = @q[after_state]
      max_q_after = q_after ? q_after.values.max : -1

      unless @q[@state_before_action]
        @q[@state_before_action] = { jump: 0, idle: 0 }
      end
      was = @q[@state_before_action][@action]
      @q[@state_before_action][@action] = reward + GAMMA * max_q_after
      # puts "Update #{was} with #{@q[@state_before_action][@action]}" if reward == -1_000
      # puts "Store in #{@state_before_action} action: #{@action} value #{@q[@state_before_action][@action]}"

      # print_q
    end

    private

    def state
      scan = @sonar.scan
      State.new(scan[:bottom_of_gate], scan[:end_of_gate], !@window.flappy_bird.dead?)
    end

    def decide(state)
      # if Random::rand > 0.99
      #   puts 'Uczę się'
      #   return :jump
      # end

      # puts "decide #{state}"

      q_row = @q[state]
      if q_row
        # puts "Korzystam z wiedzy #{@knowlade_count+=1}"
        action = q_row[:jump] > q_row[:idle] ? :jump : :idle
        # puts action
        return action
      end

      :idle
    end

    def print_q
      puts 'Q max'
      pp @q.sort_by { |h, v| v.values.max }.last(3)
      puts 'Q min'
      pp @q.sort_by { |s, v| v.values.min }.take(3)
    end
  end
end
