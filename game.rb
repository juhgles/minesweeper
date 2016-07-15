require_relative 'board'

class Game

  attr_accessor :board, :game_over

  def initialize
    @board = Board.new
    @game_over = false
  end


  def play
    #take turn until over
    #print you won
    play_turn until @game_over == true
  end

  def play_turn
    @board.render
    pos = get_pos
    pos = get_pos until valid_pos?(pos)
    action = get_action
    play_move(pos, action)
    update_board(pos) if action == 1
    game_over?(bomb?(pos), action)
  end

  def update_board(pos)
    @board.adjacent_tiles(pos)
  end

  def play_move(move, action)
    @board[move].up = true if action == 1
    @board[move].flagged = true if action == 2
  end

  def get_pos
    puts "Where (0-8) x (0-8) would you like to interact with"
    pos = gets.chomp
    pos.split(",").map { |el| Integer(el) }
  end

  def valid_pos?(pos)
    valid = pos.each.all? {|el| el.is_a?(Integer) && el.between?(0,9)}
    if valid == true
      return true
    else
      puts "Invalid move!"
    end
  end

  def get_action
    puts "Enter 1 to reveal and 2 to flag"
    action = Integer(gets.chomp)
  end

  def bomb?(pos)
    @board[pos].bomb == true
  end

  def game_over?(bomb, action)
    if bomb && action == 1
      @board.render
      puts "Kablooey! You lose!"
      @game_over = true
      true
    else
      false
    end
  end

end

game = Game.new
game.play
