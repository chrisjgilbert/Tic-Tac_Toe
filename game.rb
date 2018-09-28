class Game
  attr_accessor :board, :turn_counter

  def initialize
    @board = (1..9).to_a
    @turn_counter = 0
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def start_play
    puts "Hello, welcome to Tic Tac Toe!\nPlease enter Player 1's name!"
    player1 = Player.new(name = gets.chomp.capitalize)
    puts "Welcome #{player1.name}!"
    puts "Please enter Player 2's name!"
    player2 = Player.new(name = gets.chomp.capitalize)
    puts "Weclome #{player2.name}!"
    puts "#{player1.name}, which token would you like? 'X' or 'O'"
    player1.token=(gets.chomp.upcase)
    play_game(player1.token)
  end
  # sort out token code here...........
  def choose_token

  end

  def switch_player(token)
    token == "X" ? "O" : "X"
  end

  def play_game(token)
    until winner? || draw?
      display_board
      puts "Please enter a position! 1-9"
      position = gets.chomp.to_i
      position -= 1
      if position.between?(0,8) && @board[position].is_a?(Integer)
        move(position, token)
        token = switch_player(token)
        @turn_counter += 1
      else
        puts "That's not a valid move, please try again!"
      end
    end
  end

  def move(position, token)
    @board[position] = token
  end

  def draw?
    if turn_counter == 9 && !winner?
      puts "Gosh! That match is a draw!"
      display_board
      play_again?
      return true
    else
      return false
    end
  end

  def winner?
    winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8],[0, 3, 6], [1, 4, 7], [2, 5, 8],[0, 4, 8], [2, 4, 6]]
    winning_combos.each do |win_combo|
      if win_combo.all? { |i| @board[i] == "X" }
        puts "The winner is X!"
        display_board
        play_again?
        return true
      elsif win_combo.all? { |i| @board[i] == "O" }
        puts "The winner is O!"
        display_board
        play_again?
        return true
      end
    end
    return false
  end

  def play_again?
    puts "Would you like to play again? y/n"
    answer = gets.chomp.downcase
    if answer == "y"
      start_play
    else
      puts "Thanks for playing, goodbye!"
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :token
  def initialize(name, token="")
    @name = name
    @token = token
  end
end

# Program start....
game = Game.new
game.start_play
