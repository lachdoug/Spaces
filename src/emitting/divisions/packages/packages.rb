require_relative '../../emissions/divisible'
require_relative 'package'

module Packages
  class Packages < ::Emissions::Divisible

    class << self
      def script_lot ;end
      def inheritance_paths; __dir__ ;end
    end

  end
end
