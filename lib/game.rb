require './spec/spec_helper'


class Game

  attr_reader :player_board,
              :cpu_board

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
    place_player_ships

    until winner do
      board_display
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
    puts cpu_board.place(@cpu_cruiser, (randomize_ship_placement(@cpu_cruiser)))
    puts cpu_board.place(@cpu_submarine, (randomize_ship_placement(@cpu_submarine)))
    puts cpu_board.render(true)
  end

  def randomize_ship_placement(ship)
    coordinates = @cpu_board.cells.keys.sample(ship.length)

    while @cpu_board.valid_placement?(ship, coordinates) == false
      coordinates = @cpu_board.cells.keys.sample(ship.length)
    end
    
    coordinates
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