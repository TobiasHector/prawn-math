module Prawn
  module Math
    class WideLine < Leaf
      LineScaling = 16.0

      def set_width(width)
        self.width = width
      end

      def calculate_size
        raise "WideLine::width must be set via set_width" unless self.width
        self.height = prawn.font_size / LineScaling
      end

      def draw
        prawn.cap_style = :butt
        prawn.line_width = self.height

        bounded do
          lx = [0, width]
          ly = 0
          prawn.line [lx[0], ly], [lx[1], ly]
          prawn.stroke
        end
      end
    end
    
    class WideTilde < WideLine
      def calculate_size
        super
        raise "WideLine::width must be set via set_width" unless self.width
        self.height = prawn.font_size / LineScaling
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = self.height
        
        x = [0.0, width / 2.0, width]
        y = [0.0,prawn.font_size / 8.0,prawn.font_size / 4.0]

        bounded do
          line_y = self.y + (self.height / 2)
          pdf.stroke do
            pdf.move_to x[0], y

            pdf.curve_to [x[1], y], :bounds => [[x[0], y + yoffset], [x[1], y + yoffset]]

            pdf.curve_to [x[2], y], :bounds => [[x[1], y - yoffset], [x[2], y - yoffset]]
          end
        end
      end
    end

    class Underline < Node
      def calculate_size
        children[0].calculate_size
        children[1].set_width(children[0].width)
        children[1].calculate_size

        self.width = children[0].width
        self.height = children[0].height + children[1].height * 2.0
      end

      def calculate_offsets
        children[0].x = 0
        children[0].y = children[1].height
        children[1].x = 0
        children[1].y = children[1].height
      end
    end

    class Overline < Node
      def calculate_size
        children[1].calculate_size
        children[0].set_width(children[1].width)
        children[0].calculate_size

        self.width = children[1].width
        self.height = children[1].height + children[0].height * 2.0
      end
      
      def calculate_offsets
        children[0].x = 0
        children[0].y = children[1].height + children[0].height
        children[1].x = 0
        children[1].y = children[0].height
      end
    end

    class Equation < Row
      module Lines
        def underline(halign: :left, valign: :top, &block)
          underline = Prawn::Math::Underline.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            yield
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end

        def overline(halign: :left, valign: :top, &block)
          overline = Prawn::Math::Overline.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
            yield
          end
          overline.calculate_size
          overline.calculate_offsets
        end
      end
    end
  end
end