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
    valid_number_array = (1..4).each_cons(coordinates.length)
    valid_letter_array = ("A".."D").each_cons(coordinates.length)
    numbers_array = []
    letters_array = []
    coordinates.each do |coordinate|
      letters_array << coordinate.split("").first
      numbers_array << coordinate.split("").last.to_i
    end

    if (valid_letter_array.include?(letters_array) ^ 
        valid_number_array.include?(numbers_array)) &&
        ship_type.length == coordinates.length
      return true
    else
      return false
    end
  end

  def place(ship_type, coordinates)
    coordinates.map do |coordinate|
      @cells[coordinate].place_ship(ship_type) if valid_placement?(ship_type, coordinates)
    end
  end
end