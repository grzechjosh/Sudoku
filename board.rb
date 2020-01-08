require 'colorize'
require 'byebug'
class Board
    def initialize(filePath)
        sudoku_game = File.open(filePath).read
        lineCount = sudoku_game.lines.count
        @boardArray = Array.new(lineCount) {Array.new(lineCount)}
        @playerGuesses = Hash.new(0)
        rowIdx = 0
        columnIdx = 0
        sudoku_game.each_line do |line|
            columnIdx = 0
            line.each_char do |char|
                unless char == "\n"
                    @boardArray[rowIdx][columnIdx] = Tile.new(char)
                    columnIdx += 1
                end
            end
            rowIdx += 1
        end
        @boardConstants = Hash.new(0)
        @boardArray.each_with_index do |row, rowIdx|
            row.each_with_index do |value, colIdx|
                unless value.value == 0
                    @boardConstants[[rowIdx, colIdx]] = value.value
                end
            end
        end
        @solutionArray = Array.new(lineCount) {Array.new(lineCount)}
        self.solutionArray
        self.solve
        return " "
    end
    def boardConstants
        @boardConstants
    end
    def render
        renderArray = Array.new(@boardArray.length) {Array.new(@boardArray.length)}
        @boardArray.each_with_index do |row, rowidx|
            row.each_with_index do |tile, tileidx|
                if  @playerGuesses.has_value?(tile.value)
                    if @playerGuesses.has_key?([rowidx, tileidx])
                        tileColored = tile.to_string.colorize(:blue)
                        renderArray[rowidx][tileidx] = tileColored
                    else
                        tileColored = tile.to_string.colorize(:red)
                        renderArray[rowidx][tileidx] = tileColored
                    end
                elsif tile.is_constant?
                    tileColored = tile.to_string.colorize(:black)
                    renderArray[rowidx][tileidx] = tileColored
                else
                    tileColored = tile.to_string.colorize(:red)
                    renderArray[rowidx][tileidx] = tileColored
                end
            end
        end
        renderArray.each do |row|
            puts row.join(" ")
        end
        return "This is the current board. | Black = Constant Values | Solve for the Red Values."
    end
    def position(arr, val)
        row, column = arr
        if @boardArray[row][column].value == 0
            @boardArray[row][column] = Tile.new(val)
            @playerGuesses[arr] = val
        elsif @playerGuesses.has_key?(arr)
            @boardArray[row][column] = Tile.new(val)
            @playerGuesses[arr] = val
        else
            return "You cannot change a given constant on the board. Please try again."
        end
    end
    def self.is_full?(array)
        array.each do |val|
            if val == 0
                return false
            end
        end
        return true
    end
    def is_full?
        @boardArray.each do |row|
            row.each do |val|
                if val.value == 0
                    return false
                end
            end
        end
        return true
    end
    def solutionArray
        @boardArray.each_with_index do |row, rowIdx|
            row.each_with_index do |tile, column|
                @solutionArray[rowIdx][column] = tile.value
            end
        end
    end
    def row_solution(startIdx)
        rowConstants = []
        solvedArray = []
        row, thisColumn = startIdx
        rowHash = Hash.new{0}
        @boardConstants.each do |key, value|
            if key[0] == row
                rowConstants << value
                rowHash[key] = value
            end
        end
        @solutionArray[row].each_with_index do |value, colIdx|
            rowHash[[row, colIdx]] = value
        end
        valHash = Hash.new(0)
        rowHash.each_value do |v|
            valHash[v] += 1
        end
        i = 1
        numTimes = @boardArray.length
        while Board.is_full?(@solutionArray[row]) == false
            if rowHash.has_value?(i) == false
                rowHash.each do |tileIndex, tileValue|
                    row1, column1 = tileIndex
                    if valHash[tileValue] > 1
                        if !solvedArray.include?(i)
                            if !rowConstants.include?(i)
                                @solutionArray[row1][column1] = i
                                rowHash[[row1, column1]] = i
                                solvedArray << i
                            end
                        end
                    end
                end
            end
            if i >= numTimes 
                i -= 1
            else
                i += 1
            end
        end
    end
    def col_solution(startIdx)
        colConstants = []
        solvedArray = []
        columnHash = Hash.new(0)
        row, thisColumn = startIdx
        @boardConstants.each do |key, value|
            if key[1] == thisColumn
                colConstants << value
                columnHash[key] = value
            end
        end
        valHash = Hash.new(0)
        columnHash.each_value do |v|
            valHash[v] += 1
        end
        columnArray = []
        @solutionArray.each_with_index do |row, idx1|
            row.each_with_index do |value, idx2|
                if idx2 == thisColumn
                    columnArray << value
                end
            end
        end
        columnHash
        
        
        
    end
    def cube_solution

    end
    def solve
        self.solutionArray

    end
    def solved?

    end
    def render_solution
        
    end
    def solution
        @solutionArray
    end
end
