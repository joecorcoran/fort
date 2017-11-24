require 'gosu'

class Game < Gosu::Window
  def initialize
    super 1200, 800
    self.caption = 'Fort'
  end
end

Game.new.show
