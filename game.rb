class Game
  attr_accessor :board, :turn_counter

  def initialize
    @board = ["","","","","","","","","",]
    @turn_counter = 0
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "--------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "--------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def start_play
    puts "Hello, welcome to Tic Tac Toe!\nPlease enter Player 1's name!"
    player1 = Player.new(name = gets.chomp.capitalize)
    puts "Welcome #{name}!"
    turn
  end

  def move(position, token="X")
    @board[position] = token
  end

  def winner?
    winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                      [0, 3, 6], [1, 4, 7], [2, 5, 8],
                      [0, 4, 8], [2, 4, 6]]

    winning_combos.each do |win_combo|
      if win_combo.all? { |i| @board[i] == "X" }
        puts "The winner is X!"
        return true

      elsif win_combo.all? { |i| @board[i] == "O" }
        puts "The winner is O!"
        return true

      end
    end
    return false
  end

  def draw?
    turn_counter == 9 && !winner?
  end

  def turn(token="X")
    loop do
      display_board
      puts "Please enter a position you would like to move take (1-9)"
      position = gets.chomp.to_i
      position -= 1
      if position.between?(0,8) && @board[position] == ""
        move(position)
        display_board
        puts "Nice move!"
        @turn_counter += 1
      else
        puts "That's not a valid move, please try again!"
      end
      break if winner? || draw?
    end
    if draw?
      puts "That's a draw!"
    end
  end

end

class Player
  attr_reader :name, :token
  def initialize(name, token="X")
    @name = name
    @token = token
  end
end

game = Game.new
game.start_play
