require_relative '../nodule'

module Nodules
  module Pear
    class Pear < Nodule

      Dir["#{__dir__}/scripts/*"].each { |f| require f }

      class << self
        def identifier
          'pear'
        end
      end

    end
  end
end