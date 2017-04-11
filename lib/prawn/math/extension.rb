require_relative 'equation.rb'

module Prawn
  module Math
    module Extension
      #
      # Draws an equation into the PDF
      #
      # Example usage:
      #
      #   equation do
      #     text('a = b')
      #   end
      #
      def equation(halign: :left, valign: :top, spacing: 0.25, &block)
        Prawn::Math::Equation.new(self, halign: halign, valign: valign, spacing: spacing, &block)
      end
    end
  end
end