require 'prawn'
#require 'prawn/math/version'
require_relative 'prawn/math/extension'

require_relative 'prawn/math/equation'

Prawn::Document.extensions << Prawn::Math::Extension
