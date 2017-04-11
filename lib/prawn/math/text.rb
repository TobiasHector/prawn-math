module Prawn
  module Math
    class Text < Leaf
      def initialize(prawn, string, **options)
        super(prawn, options)
        @string = string
      end

      def calculate_size
        self.width = prawn.width_of(@string)
        self.height = prawn.font_size.to_f
      end

      def draw
        # TODO: Check if the text will cause a new line, and abort like crazy if it does.
        bounded do
          prawn.text @string, :valign => :center, :halign => :center
        end
      end
    end

    class Equation < Row
      module Text
        def text(string, halign: :left, valign: :top)
          text = Prawn::Math::Text.new(prawn, string, halign: :left, valign: :top)
          add_child(text)
          text.calculate_size
        end
      end
    end
  end
end