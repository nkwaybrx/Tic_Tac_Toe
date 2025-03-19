class Game
  def initialize
    @board = %w[_ _ _ _ _ _ _ _ _]
    @move = 0
    @game_is_played = true
    instructions
    get_names
  end

  def instructions
    barrier = '-----------'
    puts 'Type the number in your desired cell in order to move:'
    puts ' '
    puts [' 1 ' + '|' + ' 2 ' + '|' + ' 3 ']
    puts barrier
    puts [' 4 ' + '|' + ' 5 ' + '|' + ' 6 ']
    puts barrier
    puts [' 7 ' + '|' + ' 8 ' + '|' + ' 9 ']
    puts ' '
  end

  def get_names
    puts 'But first - player 1, type in your name:'
    @first_player = gets.to_s.capitalize!
    puts ' '
    puts 'Player 2, type in your name:'
    @second_player = gets.to_s.capitalize!
    puts ' '
    puts ' '
  end

  def view_board
    barrier = '-----------'
    puts [" #{@board[0]} " + '|' + " #{@board[1]} " + '|' + " #{@board[2]} "]
    puts barrier
    puts [" #{@board[3]} " + '|' + " #{@board[4]} " + '|' + " #{@board[5]} "]
    puts barrier
    puts [" #{@board[6]} " + '|' + " #{@board[7]} " + '|' + " #{@board[8]} "]
  end

  def is_game_being_played?
    @game_is_played = if @board.any? { |item| item == '_' }
                        true
                      else
                        false
                      end
  end

  def ask_for_x_move
    loop do
      puts view_board
      puts "#{@first_player.strip}, make your move:"
      @move = gets.to_i
      if (1..9).to_a.include?(@move) && @board[@move - 1] == '_'
        @board[@move - 1] = 'x'
        break
      else
        puts 'You must enter a valid position. Try again:'
      end
    end
  end

  def ask_for_o_move
    loop do
      puts view_board
      puts "#{@second_player.strip}, make your move:"
      @move = gets.to_i
      if (1..9).to_a.include?(@move) && @board[@move - 1] == '_'
        @board[@move - 1] = 'o'
        break
      else
        puts 'You must enter a valid position. Try again:'
      end
    end
  end

  def play_game
    until @game_is_played == false
      is_game_being_played?
      has_player_won
      break if @game_is_played == false

      ask_for_x_move
      is_game_being_played?
      has_player_won
      break if @game_is_played == false

      ask_for_o_move
    end
  end

  def has_player_won
    WIN_COMBINATIONS.each do |comb|
      if comb.all? { |pos| @board[pos] == 'x' }
        @game_is_played = false
        puts "#{@first_player.strip}, you won! Congratulations!"
        break
      elsif comb.all? { |pos| @board[pos] == 'o' }
        @game_is_played = false
        puts "#{@second_player.strip}, you won! Congratulations!"
        break
      elsif @board.none? { |item| item == '_' }
        puts 'Wow! Everything is tied with each other!'
        @game_is_played = false
        break
      end
    end
  end
  WIN_COMBINATIONS = [
    [0, 1, 2], # top_row
    [3, 4, 5], # middle_row
    [6, 7, 8], # bottom_row
    [0, 3, 6], # left_column
    [1, 4, 7], # center_column
    [2, 5, 8], # right_column
    [0, 4, 8], # left_diagonal
    [6, 4, 2] # right_diagonal
  ]
end

game = Game.new
game.play_game
