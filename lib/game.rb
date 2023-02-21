require './spec/spec_helper'


class Game

  attr_reader :player_board,
              :cpu_board,
              :player_cruiser,
              :player_submarine,
              :cpu_cruiser,
              :cpu_submarine,
              :cpu_guess_pool,
              :player_guess_pool

  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @cpu_guess_pool = @player_board.cells.keys
    @player_guess_pool = @cpu_board.cells.keys
  end
            
  def start
    main_menu
    place_cpu_ships
    explanation
    place_player_cruiser
    place_player_submarine
    boards_display
    sleep (2)
    
    until winner? do
      turns
    end
  end

  def main_menu
    system("clear")
    puts "Welcome to BATTLESHIP"
    puts " "
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

    if (cr_coordinates & @player_board.cells.keys) == cr_coordinates &&
        @player_board.valid_placement?(@player_cruiser, cr_coordinates) == true 
          @player_board.place(@player_cruiser, cr_coordinates)
    else
      puts "I'm sorry, those are not valid coordinates. Try again!"
      place_player_cruiser
    end
  end

  def place_player_submarine
    puts "Enter your Submarine coordinates: example: B1 C1"
    sb_coordinates = gets.chomp.upcase.split(" ")

    if (sb_coordinates & @player_board.cells.keys) == sb_coordinates &&
        @player_board.valid_placement?(@player_submarine, sb_coordinates) == true
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
    puts " "
    puts "Hello welcome to Battleship!"
    puts " "
    sleep(1.5)
    puts "In this game you will try and guess where my ships are before I guess where yours are."
    puts " "
    sleep(1.5)
    puts "Good luck.. now place your ships. As soon as you're done with that I will start the game."
    puts " "
  end

  def winner?
    if @player_cruiser.sunk? && player_submarine.sunk? == true
      puts "I win! You suck!"
      @cpu_guess_pool = @player_board.cells.keys
      @player_guess_pool = @cpu_board.cells.keys
      main_menu
    elsif @cpu_cruiser.sunk? && cpu_submarine.sunk? == true
      puts "I lose... you cheated."
      @cpu_guess_pool = @player_board.cells.keys
      @player_guess_pool = @cpu_board.cells.keys
      main_menu
    else
      false
    end

  end

  def boards_display
    puts " "
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "--------cpu board---------"
    puts @cpu_board.render
    puts "--------------------------"
    puts "-------player board-------"
    puts @player_board.render(true)
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "//////////////////////////"
    puts " "
  end

  def turns
    cpu_shot = @player_board.cells.keys.sample(1)[0]
    @cpu_guess_pool.delete(cpu_shot)

    cpu_move(cpu_shot)
   
    sleep(1)

    boards_display

    sleep(1)

    puts "Now its your turn. Now choose a coordinate on the board example: #{@player_guess_pool.sample}"

    player_shot = gets.chomp.upcase.to_s
    player_move(player_shot)

    boards_display
  end

  def player_move(shot)
    # require 'pry'; binding.pry
    if @player_guess_pool.include?(shot)
      @cpu_board.cells[shot].fire_upon
      if @cpu_board.cells[shot].empty? == false && @cpu_board.cells[shot].ship.sunk? == true
        puts "Your shot on #{shot} was a hit and you sunk my #{@cpu_board.cells[shot].ship.name}!"
      elsif @cpu_board.cells[shot].empty? == false 
        puts "Your shot on #{shot} was a hit!"
      elsif @cpu_board.cells[shot].empty? == true 
        puts "Your shot on #{shot} was a miss!"
      end
      sleep(2)
      @player_guess_pool.delete(shot)
    else
      p "I'm sorry, that's not a valid move. Try again!"
      shot = gets.chomp.to_s.upcase
      player_move(shot)
    end
  end

  def cpu_move(shot)
    @player_board.cells[shot].fire_upon
    if @player_board.cells[shot].empty? == false && @player_board.cells[shot].ship.sunk? == true
      puts "My shot on #{shot} was a hit and I sunk your #{@player_board.cells[shot].ship.name}!"
    elsif @player_board.cells[shot].empty? == false 
      puts "My shot on #{shot} was a hit!"
    elsif @player_board.cells[shot].empty? == true 
      puts "My shot on #{shot} was a miss!"
    end
  end
end