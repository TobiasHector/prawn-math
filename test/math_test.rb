require 'prawn'
require_relative '../lib/prawn-math.rb'

pdf = Prawn::Document.new

pdf.equation do
  text('Hi. ')

  underline do
    text('Tobias')
  end

  text(' ')

  overline do
    text('says "HELLO!"')
  end
end

pdf.equation do
  text('Hi. ')

  text('Tobias says "HELLO!"')
end

pdf.equation do
  text('Hi. Tobias says "HELLO!"')
end


pdf.equation do
  text('Yo whatsup')
  column do
    text('Flirty')
    text('Cows')
  end
end

pdf.equation do
  text('Yo whatsup')
  column do
    text('Flirty')
    overline do
      text('Cows')
    end
  end
end

pdf.equation do
  text('Yo whatsup')
  column do
    underline do
      text('Flirty')
    end
    overline do
      text('Cows')
    end
  end
end


pdf.equation do
  text('Yo whatsup')
  column(spacing: 20, valign: :top) do
    underline do
      text('ENORMOUSLYLONGSENTENCEASASINGLEWORDFORSOMEREASON')
    end
    overline do
      text('Cows')
    end
  end
end

pdf.text ''

pdf.equation do
  overtilde do
    text('Cows')
  end
  overtilde do
    text('CCCC')
  end
  overline do
    text('Cows')
  end
  text('Cows')
  underline do
    text('Cows')
  end
  undertilde do
    text('Cows')
  end
end

pdf.equation do
  column do
    text 'INSIDE'
    text 'INSIDE'
    text 'INSIDE'
  end
end
pdf.text 'OUTSIDE'

pdf.text 'Hiiiiiiiiiiiiiiiiiiiiiiiiiii'
pdf.text 'Hiiiiiiiiiiiiiiiiiiiiiiiiiii'
pdf.text ' '
pdf.text ' '

pdf.equation do
  row do
    column do
      text('1')
      text('2')
      text('3')
    end
    column do
      text('4')
      text('5')
      text('6')
    end
    column do
      text('7')
      text('8')
      text('9')
    end
  end
end

pdf.text ' '

pdf.equation do
  column do
    row do
      text('1')
      text('2')
      text('3')
    end
    row do
      text('4')
      text('5')
      text('6')
    end
    row do
      text('7')
      text('8')
      text('9')
    end
  end
end

pdf.text ' '

pdf.equation do
  row do
    (30).times do
      column do
        text('1')
        text('2')
        text('3')
      end
      column do
        text('4')
        text('5')
        text('6')
      end
      column do
        text('7')
        text('8')
        text('9')
      end
    end
  end
end

pdf.render_file "prawn-test.pdf"