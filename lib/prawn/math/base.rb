module Prawn
  module Math    
    class Leaf
      attr_reader :prawn
      attr_accessor :x
      attr_accessor :y
      attr_accessor :width
      attr_accessor :height
      attr_reader :halign
      attr_reader :valign
      
      def initialize(prawn, halign:, valign:)
        @prawn = prawn
        @halign = halign
        @valign = valign
      end
      
      def calculate_size() raise "calculate_size must be overridden, and it must set the 'width' and 'height' parameters"; end
      def draw() raise "draw must be overridden; must draw the node's content"; end
      
      # Useful Render Methods
      def bounded(&block)
        prawn.bounding_box([@x, @y + @height], :width => @width, :height => @height) do
          yield
        end
      end
      
      def scaled(scale_factor, min_font_size, &block)
        old_font_size = prawn.font_size      
        prawn.font_size = [old_font_size * scale_factor, min_font_size].max
        
        yield
        
        prawn.font_size = old_font_size
      end
    end
    
    class Node < Leaf
      attr_reader :children
      
      def initialize(prawn, **options)
        super(prawn, options)
        @children = []
      end
    
      def add_child(child)
        children << child
      end
      
      def calculate_offsets() raise "calculate_offsets must be overridden, and it should set the x and y parameters of children appropriately"; end
      
      def draw
        bounded do
          # prawn.stroke_bounds
          children.each do |child|
            child.draw
          end
        end      
      end
    end
    
    class Row < Node
      def initialize(prawn, spacing:, **options)
        super(prawn, options)
        @spacing = spacing
      end
      
      def calculate_offsets
        offset = 0
        children.each do |child|
          child.x = offset
          child.y = (child.height - self.height)/2
          offset += child.width
          offset += @spacing
        end
      end
      
      def calculate_size
        child_width = 0
        child_height_max = 0
        children.each do |child|
          child_width += child.width
          child_height_max = [child_height_max, child.height].max
        end
        self.width = child_width + ((children.length - 1) * @spacing)
        self.height = child_height_max
      end
    end
    
    class Column < Node    
      def initialize(prawn, spacing:, **options)
        super(prawn, options)
        @spacing = spacing
      end
      
      def calculate_offsets
        offset = 0
        children.each do |child|
          child.y = offset
          child.x = (self.width - child.width)/2
          offset -= child.height
          offset -= @spacing
        end
      end
      
      def calculate_size
        child_width_max = 0
        child_height = 0
        children.each do |child|
          child_width_max = [child_width_max, child.width].max
          child_height += child.height
        end
        self.width = child_width_max
        self.height = child_height + ((children.length - 1) * @spacing)
      end
    end
    
    class Equation < Row
      module Layout
        def column(halign: :left, valign: :top, spacing: 1, &block)
          column = Prawn::Math::Column.new(prawn, halign: halign, valign: valign, spacing: spacing)

          add_subtree(column) do
            yield
          end
          column.calculate_size
          column.calculate_offsets
        end
        
        def row(halign: :left, valign: :top, spacing: 1, &block)
          row = Prawn::Math::Row.new(prawn, halign: halign, valign: valign, spacing: spacing)

          add_subtree(row) do
            yield
          end
          row.calculate_size
          row.calculate_offsets
        end
      end
    end
  end
end