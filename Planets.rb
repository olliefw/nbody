require "gosu"


class Planets
  attr_reader :x_pos, :y_pos, :x_vel, :y_vel, :mass, :force_x, :force_y
  def initialize (x_pos, y_pos, x_vel, y_vel, mass, planet_image, sizeu)
    @x_pos = x_pos
    @y_pos = y_pos
    @x_vel = x_vel
    @y_vel = y_vel
    @mass = mass
    @planet_image = planet_image
    @force_x = 0
    @force_y = 0
    @G = 6.674e-11
    @sizeu = sizeu
  end

  def forcex(x, y, mass)
    force = (@G * @mass * mass)/((@x_pos - x)**2 + (@y_pos - y)**2)
    @force_x -= force * (@x_pos - x)/ (Math.sqrt((@x_pos - x)**2 + (@y_pos - y)**2))
  end
  def forcey(x, y, mass)
    force = (@G * @mass * mass)/((@x_pos - x)**2 + (@y_pos - y)**2)
    @force_y -= force * (@x_pos - y) / (Math.sqrt((@y_pos - y)**2 + (@y_pos - y)**2))
    puts @force_y
  end


  def accx
    acc = @mass / @force_x
    @x_vel += acc * 25000
    @x_pos += @x_vel * 25000
  end

  def accy
    acc = @mass / @force_y
    @y_vel += acc * 25000
    @y_pos += @y_vel * 25000
  end

  def backto0
    @force_x = 0
    @force_y = 0

  end

  def draw
    #puts @planet_image
     #puts(@x_pos / @sizeu)*320 + 640/2 - @planet_image.width / 2
      @planet_image.draw((@x_pos / @sizeu)*320 + 640/2 - @planet_image.width / 2,(@y_pos / @sizeu)*320 + 640 / 2 - @planet_image.height / 2, 1 )




  end
end
