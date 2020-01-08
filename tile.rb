require 'colorize'
String.disable_colorization = false

class Tile
    def initialize(num)
        @tileValue = num.to_i
        return " "
    end
    def value 
        @tileValue
    end
    def to_string
        return "#{@tileValue}"
    end
    def is_constant?
        unless @tileValue == 0
            return true
        else
            return false
        end
    end
end