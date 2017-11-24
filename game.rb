require 'gosu'

W = 1200
H = 800

class Missile
  attr_accessor :x, :y

  def initialize(target_x, target_y)
    @target_x, @target_y = target_x, target_y
    @image = Gosu::Image.new('img/mac-pro.png')
    @x, @y = 0, rand(H / 2).to_i
    @alive = true
  end

  def alive?
    @alive
  end

  def bottom_right
    [x + @image.width, y + @image.height]
  end

  def collides?(thing)
    brx, bry = bottom_right
    brx >= thing.x && bry >= thing.y 
  end

  def stop!
    @alive = false
  end

  def move
    return unless @alive
    @x += 12 if @x < @target_x
    @y += 4 if @y < @target_y
  end

  def draw
    @image.draw(x, y, 1)
  end
end

class Travis
  attr_accessor :x, :y

  def initialize
    @image = Gosu::Image.new('img/travis.png')
    @exp = Gosu::Image.new('img/explosion.png')
    @sound = Gosu::Sample.new('mp3/explosion.mp3')
    @x = W - @image.width - 30
    @y = H - @image.height - 30
    @alive = true
  end

  def alive?
    @alive
  end

  def kill!
    @alive = false
    @sound.play
  end

  def draw
    alive? ? @image.draw(x, y, 1) : @exp.draw(x, y, 1)
  end
end

class Game < Gosu::Window
  def initialize
    super W, H
    self.caption = 'Fort'
    @bg = Gosu::Image.new('img/bg.jpg', tileable: true)
    @travis = Travis.new
    @missiles = []
  end

  def update
    # check if collision
    if @missiles.any? { |m| m.collides?(@travis) } 
      @travis.kill! if @travis.alive?
    # carry on
    else
      # add new missile
      if rand(500) < 4
        @missiles << Missile.new(W, H)
      end

      # move existing missiles
      @missiles.each &:move
    end
  end

  def draw
    @bg.draw(0, 0, 0, 1.3, 1.3)
    @travis.draw
    @missiles.select { |m| m.alive? }.each &:draw
  end
end

Game.new.show
