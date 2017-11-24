require 'gosu'

class Game < Gosu::Window
  def initialize
    super 1200, 800
    self.caption = 'Fort'
    @bg = Gosu::Image.new('img/bg.jpg', tileable: true)
  end

  def draw
    @bg.draw(0, 0, 0, 1.3, 1.3)
  end
end

Game.new.show
