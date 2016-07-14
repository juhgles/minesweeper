require_relative 'tile'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
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
    debugger
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
