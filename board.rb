require './tile.rb'
require 'pry'

class Board
    attr_reader :display_board

    def initialize
        @board= arrays_to_tiles
    end

    def import_file_as_arrays
        arrayed_board= []
        pre_load = File.open("sudoku1.txt")
        line_read = pre_load.read.split("\n")
        line_read.each do |line|
            arrayed_board << line.split("").map(&:to_i)
        end
        arrayed_board
    end

    def arrays_to_tiles
        tiled = []
        original_board = import_file_as_arrays
        original_board.each do |row|
            tiled_row =[]
            row.each do |square|
                tiled_row << Tile.new(square)
            end
            tiled << tiled_row
        end
        tiled
    end

    def display_board
        @board.each_with_index do |row, i|
            if i == 3 || i == 6
                puts "-----------------------------"
            end
            row.each_with_index do |tile, column|
                if column == 3 || column == 6
                    print "|"
                end
                print tile.display
            end
            print "\n"
        end
        nil
    end

    
    def move(row,column,new_value)
        @board[row][column].value = new_value
    end

    def row_done?(row)
        row_sorted = []
        @board[row].each do |tile|
            row_sorted << tile.value
        end
        row_sorted.sort == (1..9).to_a
    end

    def column_done?(column)
        columned = @board.transpose
        row_done?(column)
    end

    def boxes_done?()
        (0..2).each do |i|
            (0..2).each do |j|
                if get_section(i,j).sort != (1..9).to_a
                    return false
                end
            end
        end
        return true
    end

    def get_section(lat,long)
        case lat
        when 0 then area = 0..2
        when 1 then area = 3..5
        when 2 then area = 6..8
        else return "Something went wrong"
        end
        case long
        when 0 then section = [0,1,2]
        when 1 then section = [3,4,5]
        when 2 then section = [6,7,8]
        else return "Something went wrong"
        end
        box=[]
        
        @board[area].each_with_index do |row|
            
            inner_row = []
            row.each_with_index do |ele,i|
                if section.include?(i)
                    box << ele.value
                end
            end
            
        end
        box
    end
end