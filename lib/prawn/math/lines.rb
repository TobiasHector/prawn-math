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
        prawn.line_width = line_width

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
        raise "WideTilde::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = line_width

        bounded do
          lx = [0,  width / 2.0,  width]
          ly = [0, height / 2.0, height]

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
    
    class WideHat < WideLine
      def calculate_size
        raise "WideHat::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :butt
        prawn.line_width = line_width

        bounded do
          lx = [0, width / 2.0,  width]
          ly = [0, height]

          prawn.line [lx[0], ly[0]], [lx[1], ly[1]]
          prawn.line [lx[1], ly[1]], [lx[2], ly[0]]
          prawn.stroke
        end
      end
    end
    
    class WideTilde < WideLine
      def calculate_size
        raise "WideTilde::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = line_width

        bounded do
          lx = [0,  width / 2.0,  width]
          ly = [0, height / 2.0, height]

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
    
    class WideTopBrace < WideLine
      def calculate_size
        raise "WideTilde::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = line_width

        bounded do
          lx = [0.0, width / 4.0, width / 2.0, 3.0 * width / 4.0, width]
          ly = [0, height / 2.0, height]

          xoffset = width / 8.0
          bx = [lx[0], lx[1] - xoffset, lx[1] + xoffset, lx[2], lx[3] - xoffset, lx[3] + xoffset, lx[4]]          
          by = ly[1]

          prawn.stroke do
            prawn.move_to lx[0], ly[0]

            prawn.curve_to [lx[1], ly[1]], :bounds => [[bx[0], by], [bx[1], by]]

            prawn.curve_to [lx[2], ly[2]], :bounds => [[bx[2], by], [bx[3], by]]
          end

          prawn.stroke do
            prawn.move_to lx[2], ly[2]

            prawn.curve_to [lx[3], ly[1]], :bounds => [[bx[3], by], [bx[4], by]]

            prawn.curve_to [lx[4], ly[0]], :bounds => [[bx[5], by], [bx[6], by]]
          end
        end
      end
    end
    
    class WideBottomBrace < WideLine
      def calculate_size
        raise "WideTilde::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 4.0
      end

      def draw
        prawn.cap_style = :round
        prawn.line_width = line_width

        bounded do
          lx = [0.0, width / 4.0, width / 2.0, 3.0 * width / 4.0, width]
          ly = [height, height / 2.0, 0]

          xoffset = width / 8.0
          bx = [lx[0], lx[1] - xoffset, lx[1] + xoffset, lx[2], lx[3] - xoffset, lx[3] + xoffset, lx[4]]          
          by = ly[1]

          prawn.stroke do
            prawn.move_to lx[0], ly[0]

            prawn.curve_to [lx[1], ly[1]], :bounds => [[bx[0], by], [bx[1], by]]

            prawn.curve_to [lx[2], ly[2]], :bounds => [[bx[2], by], [bx[3], by]]
          end

          prawn.stroke do
            prawn.move_to lx[2], ly[2]

            prawn.curve_to [lx[3], ly[1]], :bounds => [[bx[3], by], [bx[4], by]]

            prawn.curve_to [lx[4], ly[0]], :bounds => [[bx[5], by], [bx[6], by]]
          end
        end
      end
    end
    
    class LeftArrow < WideLine
      def calculate_size
        raise "LeftArrow::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 2.0
      end

      def draw
        prawn.cap_style = :projecting_square
        prawn.line_width = line_width

        bounded do
          lx = [0, height / 2.0, width]
          ly = [0, height / 2.0, height]
          prawn.cap_style = :projecting_square
          prawn.line [lx[1], ly[0]], [lx[0], ly[1]]
          prawn.line [lx[0], ly[1]], [lx[1], ly[2]]
          prawn.stroke
          prawn.cap_style = :butt
          prawn.line [lx[0], ly[1]], [lx[2], ly[1]]
          prawn.stroke
        end
      end
    end
    
    class RightArrow < WideLine
      def calculate_size
        raise "RightArrow::width must be set via set_width" unless self.width
        self.height = prawn.font_size / 2.0
      end

      def draw
        prawn.cap_style = :projecting_square
        prawn.line_width = line_width

        bounded do
          lx = [width, width - height / 2.0, 0]
          ly = [0, height / 2.0, height]
          prawn.cap_style = :projecting_square
          prawn.line [lx[1], ly[0]], [lx[0], ly[1]]
          prawn.line [lx[0], ly[1]], [lx[1], ly[2]]
          prawn.stroke
          prawn.cap_style = :butt
          prawn.line [lx[0], ly[1]], [lx[2], ly[1]]
          prawn.stroke
        end
      end
    end

    class Underlined < Node
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
        children[1].y = 0
      end
    end

    class Overlined < Node
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
        def underline(halign: :left, valign: :top, spacing: 0.25, &block)
          underline = Prawn::Math::Underlined.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end

        def underleftarrow(halign: :left, valign: :top, spacing: 0.25, &block)
          underline = Prawn::Math::Underlined.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::LeftArrow.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end
        
        def underrightarrow(halign: :left, valign: :top, spacing: 0.25, &block)
          underline = Prawn::Math::Underlined.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::RightArrow.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end
        
        def underbrace(halign: :left, valign: :top, spacing: 0.25, &block)
          underline = Prawn::Math::Underlined.new(prawn, halign: halign, valign: valign)

          add_subtree(underline) do
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
            add_child(Prawn::Math::WideBottomBrace.new(prawn, halign: halign, valign: valign))
          end
          underline.calculate_size
          underline.calculate_offsets
        end
        
        def overline(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideLine.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end
        
        def overleftarrow(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::LeftArrow.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end

        def overrightarrow(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::RightArrow.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end

        def overtilde(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideTilde.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end
        
        def overhat(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideHat.new(prawn, halign: halign, valign: valign))
            row(halign: halign, valign: valign, spacing: spacing) do
              yield
            end
          end
          overline.calculate_size
          overline.calculate_offsets
        end
        
        def overbrace(halign: :left, valign: :top, spacing: 0.25, &block)
          overline = Prawn::Math::Overlined.new(prawn, halign: halign, valign: valign)

          add_subtree(overline) do
            add_child(Prawn::Math::WideTopBrace.new(prawn, halign: halign, valign: valign))
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