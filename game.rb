require 'byebug'
require_relative 'board.rb'
require_relative 'tile.rb'
require 'colorize'
class Sudoku
    def initialize(filePath)
        @board = Board.new(filePath)
        return "The Game is starting now."
        @checkCount = 0
    end
    def play_game
        @board.solutionArray
        @board.solve
        while @board.is_full? == false
            @board.render
            puts "Please enter a row # to focus on.".colorize(:green)
            row = gets.chomp.to_i - 1
            puts "Please enter a tile # to focus on.".colorize(:green)
            column = gets.chomp.to_i - 1
            puts "Please enter the value you'd like to place in the tile.".colorize(:green)
            value = gets.chomp.to_i
            @board.position([row, column], value)
            if checkCount < 3
                puts "Would you like to check your board against the solution? Enter y for Yes or n for No. You can only do this 3 times.".colorize(:red)
                answer1 = gets.chomp.downcase
                if answer1 == "y"
                    @checkCount += 1
                    @board.solved?
                end
            end         
        end
    end
    def board
        @board
    end
end