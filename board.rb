require_relative 'tile'
require 'byebug'
require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate
    place_bombs
  end

  def populate
    num = 1
    @grid.each_index do |row|
      @grid.each_index do |col|
        pos = [row,col]
        tile = Tile.new
        tile.value = num
        self[pos] = tile
        num += 1
      end
    end
  end

  def render
    @grid.each do |row|
      puts
      row.each do |tile|
        if tile.flagged == true
          print "F"
        elsif !tile.up
          print "*"
        elsif !tile.bomb && !tile.adj_bombs
          print "o"
          #p breadth recursive function
        elsif !tile.bomb
          print tile.adj_bombs
        else
          print "X"
          #game over
        end
        print "  "
      end
    end
    puts
  end


  def adjacent_tiles(pos)
    x, y = pos
    ugly_tiles = [[0,1], [1,0], [-1,0], [0,-1], [1,1], [-1,-1],[1,-1], [-1,1]]
    adjacent = ugly_tiles.map { |arr| [arr[0] + x, arr[1] + y] }
    adjacent.select! { |arr| arr.all? { |el| el.between?(0,8) } }
    adjacent.select! { |arr| arr if @grid[arr[0]][arr[1]].up == false }
    #debugger
    if adjacent.all? { |tile| self[tile].bomb == false }
      adjacent.each do |tile|
        i, j = tile
        @grid[i][j].up = true
        adjacent_tiles(tile)
      end
    else
      num_bombs = 0
      adjacent.each do |tile|
        i, j = tile
        num_bombs += 1 if @grid[i][j].bomb == true
      end
      @grid[x][y].adj_bombs = num_bombs
      return
    end

  end

  def place_bombs
    bomb_pos = []
    while bomb_pos.length < 9
      random = rand(81)
      unless bomb_pos.include?(random)
        @grid.each do |row|
          row.each do |tile|
            tile.bomb = true if tile.value == random
            bomb_pos << random if tile.bomb == true && tile.value == random

          end
        end
      end
    end
  end


  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end
end
