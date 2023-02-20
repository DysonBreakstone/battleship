class Cell
  attr_reader :coordinate,
              :ship, 
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fire_upon
    @fired_upon = true
    if @ship.nil?
    else 
      ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal_ship = false)
      if reveal_ship == true && empty? == false && fired_upon? == false
          return "S"
      elsif fired_upon? == true && empty? == true
          return "M"
      elsif fired_upon? == true && @ship != nil && @ship.sunk? == false
          return "H"
      elsif fired_upon? == true && empty? == false && @ship.sunk? == true
          return "X"
      else fired_upon? == false && empty? == true
          return "."
      end
  end
end