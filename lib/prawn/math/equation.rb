require_relative 'base'
require_relative 'text'
require_relative 'lines'

module Prawn
  module Math
    class Equation < Row
      include Prawn::Math::Equation::Layout
      include Prawn::Math::Equation::Text
      include Prawn::Math::Equation::Lines

      def initialize(prawn, **options, &block)
        super(prawn, options)
        @subtree_root = self
        self.x = 0
        self.y = prawn.cursor
        if block
          block.arity < 1 ? instance_eval(&block) : block[self]
        end
        calculate_size
        calculate_offsets
        draw
        prawn.move_cursor_to prawn.cursor - self.height
      end
      
      # Used by nodes
      def add_subtree(new_root, &block)
        add_child(new_root)
        old_root = @subtree_root
        @subtree_root = new_root
        yield
        @subtree_root = old_root
      end
      
      # Used by leaves
      def add_child(child)
        if @subtree_root == self
          super(child)
        else
          @subtree_root.add_child child
        end
      end
    end
  end
end