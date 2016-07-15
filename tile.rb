class Tile
  attr_accessor :up, :bomb, :value, :flagged, :adj_bombs

  def initialize
    @flagged = false
    @up = false
    @bomb = false
    @value = nil
    @adj_bombs = nil
  end

end
