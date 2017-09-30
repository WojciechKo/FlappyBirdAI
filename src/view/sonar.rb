module View
  class Sonar
    def initialize(window)
      @window = window
    end

    def draw(sonar)
      distances = sonar.scan
      font.draw("#{distances[:end_of_gate]} - end",
                10, 10, 0)
      font.draw("#{distances[:bottom_of_gate]} - bottom",
                10, 30, 0)

      font.draw("#{distances[:gate_start]} - start",
                10, 50, 0)
      font.draw("#{distances[:gate_end]} - end",
                10, 70, 0)
    end

    def width
      image.width
    end

    private

    attr_reader :window

    def font
      @font ||= Gosu::Font.new(20)
    end
  end
end
