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
end