require 'pry'
require 'colorize'

class Tile
    attr_reader :value
    def initialize(value)
        @value = value
        if value != 0
            @given = true
        else
            @given = false
        end
    end

    def display
        if @given == true
            " #{@value} ".to_s.colorize(:magenta).on_light_white
        else
            " #{@value.to_s} "
        end
    end
    
    def value
        @value
    end
    
    def value=(new_value)
        if @given == true
            puts "You can't change this value"
            @value= @value
            return false
        else
            @value=new_value
        end
    end

        
end

