require 'gosu'
require 'tictac'

class Game < Gosu::Window
  attr_accessor :width, :cell_width

  def initialize
    @width = 600
    @cell_width = @width/3
    @position = Tictac.new
    super(width, width, false)
    @font = Gosu::Font.new(self, Gosu::default_font_name, cell_width)
  end

  def button_down(id)
    case id
      when Gosu::KbQ then close
      when Gosu::MsLeft then @position = @position.move((mouse_x/cell_width).to_i + 3 *(mouse_y/cell_width).to_i)
        if !@position.possible_moves.empty? then
          index = @position.best_move
          @position = @position.move(index)
        end
    end
  end

  def needs_curser?
    true
  end

  #grid
  def draw
    [cell_width, cell_width*2].each do |w|
      draw_line(w, 0, Gosu::Color::WHITE, w, width, Gosu::Color::WHITE)
       draw_line(0, w, Gosu::Color::WHITE, width, w, Gosu::Color::WHITE)
    end

  #position
    position.board.each_with_index do |p,i|
      if p != "-"
        x = (i%3)*cell_width + @font.text_width(p)/2
        y = (i/3)*cell_width
        @font.draw(p, x, y, 0)
      end
    end

    display_message("You won!") if @position.win?("x")
    display_message("Computer won!") if @position.win?("o")
    display_message("Draw") if @position.position_moves.empty?
  end

  def siplay_message(text)
    black = Gosu::Color::BLACK
    draw_quad(0,100,black,
              width, 100, black,
              width, 500, black,
              0, 500 black)
    @font.draw(text, (width - @font.text_width(text)/2, width/2 - 100, 0))
  end
end

game = Game.new
game.show