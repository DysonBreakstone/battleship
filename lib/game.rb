require './spec/spec_helper'


class Game

  attr_reader :player_board,
              :cpu_board,
              :player_cruiser,
              :player_submarine,
              :cpu_cruiser,
              :cpu_submarine

  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
  end
            
  def start
    main_menu
    place_cpu_ships
    explanation
    place_player_cruiser
    place_player_submarine
    boards_display
    
    until winner? do
      turn
    end
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    
    player_input = gets.chomp.to_s.downcase

    if player_input == "p"
      
    elsif player_input == "q"
      puts "Coward."
      exit
    else
      puts "Please enter a valid command. Enter p to play. Enter q to quit."
      main_menu
    end
    
  end

  def place_cpu_ships
    cpu_board.place(@cpu_cruiser, (randomize_ship_placement(@cpu_cruiser)))
    cpu_board.place(@cpu_submarine, (randomize_ship_placement(@cpu_submarine)))
  end

  def place_player_cruiser
    puts "Enter your Cruiser coordinates: example: A1 A2 A3"
    cr_coordinates = gets.chomp.upcase.split(" ")
    
    if @player_board.valid_placement?(@player_cruiser, cr_coordinates) == true
      @player_board.place(@player_cruiser, cr_coordinates)
    else
      puts "I'm sorry, those are not valid coordinates. Try again!"
      place_player_cruiser
    end
  end

  def place_player_submarine
    puts "Enter your Submarine coordinates: example: B1 C1"
    sb_coordinates = gets.chomp.upcase.split(" ")

    if @player_board.valid_placement?(@player_submarine, sb_coordinates) == true
      @player_board.place(@player_submarine, sb_coordinates)
    else
      puts "I'm sorry, those are not valid coordinates. Try again!"
      place_player_submarine
    end
  end

  def randomize_ship_placement(ship)
    coordinates = @cpu_board.cells.keys.sample(ship.length)

    while @cpu_board.valid_placement?(ship, coordinates) == false
      coordinates = @cpu_board.cells.keys.sample(ship.length)
    end
    
    coordinates
  end

  def explanation
    puts "Hello welcome to Battleship!"
    sleep(1)
    puts "In this game you will try and guess where my ships are before I guess where yours are."
    sleep(1)
    puts "Good luck.. now place your ships."
  end

  def winner?
    if @player_cruiser.sunk? && player_submarine.sunk? == true
      puts "I win! You suck!"
    elsif @cpu_cruiser.sunk? && cpu_submarine.sunk? == true
      puts "I lose... you cheated."
    else
      false
    end
  end

  def boards_display
    puts "--------cpu board---------"
    puts @cpu_board.render
    puts "--------------------------"
    puts "-------player board-------"
    puts @player_board.render(true)
  end
end

# main_menu 
# start
# winner
# place_cpu_ships (computer places randomly, player uses inputs)
# place_player_ships
# turn (computer random, player by input)
# explanation (tells rules of the game)
# board_display

# cpu takes shot, show result, display board, person  takes turn,
# then display board, repeat until winner