module Prawn
  module Math
    class WideLine < Leaf
      LineScaling = 16.0

      def set_width(width)
        self.width = width
      end

      def line_width
        prawn.font_size / LineScaling
      end

      def calculate_size
        raise "WideLine::width must be set via set_width" unless self.width
        self.height = line_width
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
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = line_width

        bounded do
          lx = [0.0,  width / 2.0,  width]
          ly = [height / -2.0, 0.0, height / 2.0]

          xoffset = width / 8
          bx = [lx[0] + xoffset, lx[1] - xoffset, lx[1] + xoffset, lx[2] - xoffset]
          by = ly

          prawn.stroke do
            prawn.move_to   lx[0], ly[1]

            prawn.curve_to [lx[1], ly[1]], :bounds => [[bx[0], by[2]], [bx[1], by[2]]]

            prawn.curve_to [lx[2], ly[1]], :bounds => [[bx[2], by[0]], [bx[3], by[0]]]
          end
        end
      end
    end

    class UnderLine < Node
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

    class OverLine < Node
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
        def underline(halign: :left, valign: :top, spacing: 1, &block)
          underline = Prawn::Math::UnderLine.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end

        def overline(halign: :left, valign: :top, spacing: 1, &block)
          overline = Prawn::Math::OverLine.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end

        def undertilde(halign: :left, valign: :top, spacing: 1, &block)
          underline = Prawn::Math::UnderLine.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::WideTilde.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end

        def overtilde(halign: :left, valign: :top, spacing: 1, &block)
          overline = Prawn::Math::OverLine.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideTilde.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end

      end
    end
  end
end