require "gosu"
require_relative "z_order"
require "./Planets"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies = []
    @number_of_bodies = 0
    @size_of_simulation = 0
    create_bodies
    end

  def create_bodies
      open_simulation = File.open("simulations/planets.txt").read
      line_num = 0
      open_simulation.split("/n")

      open_simulation.each_line do |line|
        if line_num == 0
          @number_of_bodies = line.to_f
        elsif line_num == 1
          @size_of_simulation = line.to_f
        elsif line_num >=2 && line_num <= 2 + @number_of_bodies
        line_arry = line.split(" ")
          x_pos = line_arry[0].to_f
          y_pos = line_arry[1].to_f
          x_vel = line_arry[2].to_f
          y_vel = line_arry[3].to_f
          mass = line_arry[4].to_f
          planet_image = Gosu::Image.new("images/#{line_arry[5]}",tileable: true)
          @bodies.push(Planets.new(x_pos, y_pos, x_vel, y_vel, mass, planet_image, @size_of_simulation))
        end
        line_num += 1
    end
    @bodies.each do |body|
      puts body
    end
  end


  def update
    @bodies.each do |body1|
      body1.backto0
      @bodies.each do |body2|

        if body1 != body2
            body1.forcex(body2.x_pos, body2.y_pos, body2.mass)
            body1.forcey(body2.x_pos, body2.y_pos, body2.mass)

        end
      end
      body1.accx
      body1.accy

    end

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      body.draw
  end
end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

window = NbodySimulation.new
window.show
