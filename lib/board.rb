class Board

  attr_reader :cells, :valid_coordinate

  def initialize
    @cells = {"A1" => Cell.new("A1"), 
              "A2" => Cell.new("A2"), 
              "A3" => Cell.new("A3"), 
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"), 
              "B2" => Cell.new("B2"), 
              "B3" => Cell.new("B3"), 
              "B4" => Cell.new("B4"), 
              "C1" => Cell.new("C1"), 
              "C2" => Cell.new("C2"), 
              "C3" => Cell.new("C3"), 
              "C4" => Cell.new("C4"), 
              "D1" => Cell.new("D1"), 
              "D2" => Cell.new("D2"), 
              "D3" => Cell.new("D3"), 
              "D4" => Cell.new("D4") 
              }
    @valid_coordinate = @cells.values      
  end

  def valid_coordinate?(coordinate)
    @valid_coordinate.include?(@cells[coordinate]) && !@cells[coordinate].fired_upon
  end

  def valid_placement?(ship_type, coordinates)
    # require 'pry'; binding.pry
    valid_number_array = (1..4).each_cons(coordinates.length)
    valid_letter_array = ("A".."D").each_cons(coordinates.length)
    numbers_array = []
    letters_array = []
    all_empty = true
    coordinates.each do |coordinate|
      all_empty = false if !@cells[coordinate].empty?
      letters_array << coordinate.split("").first
      numbers_array << coordinate.split("").last.to_i
    end
    # require 'pry'; binding.pry
    if ((valid_letter_array.include?(letters_array) ^ 
        valid_number_array.include?(numbers_array)) &&
       ((letters_array[0] == letters_array[1]) && (letters_array [1] == letters_array[2]) ||
        (numbers_array[0] == numbers_array[1]) && (numbers_array[1] == numbers_array[2])) &&
        ship_type.length == coordinates.length &&
        all_empty == true)
      return true
    else
      return false
    end
    # require 'pry'; binding.pry
  end

  def place(ship_type, coordinates)
    if valid_placement?(ship_type, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship_type) 
      end
    end
  end

  def render(reveal_ship = false)
    row_a = [
    @cells.values[0].render(reveal_ship), 
    @cells.values[1].render(reveal_ship), 
    @cells.values[2].render(reveal_ship), 
    @cells.values[3].render(reveal_ship)
  ]

    row_b = [
    @cells.values[4].render(reveal_ship), 
    @cells.values[5].render(reveal_ship), 
    @cells.values[6].render(reveal_ship), 
    @cells.values[7].render(reveal_ship)
  ]

    row_c = [
    @cells.values[8].render(reveal_ship), 
    @cells.values[9].render(reveal_ship), 
    @cells.values[10].render(reveal_ship), 
    @cells.values[11].render(reveal_ship)
  ]

    row_d = row_c = [
    @cells.values[12].render(reveal_ship), 
    @cells.values[13].render(reveal_ship), 
    @cells.values[14].render(reveal_ship), 
    @cells.values[15].render(reveal_ship)
  ]

    board_render = "  1 2 3 4 \n" +
                  "A #{row_a.join(" ")} \n" +
                  "B #{row_b.join(" ")} \n" +
                  "C #{row_c.join(" ")} \n" +
                  "D #{row_d.join(" ")} \n"        
  end
end