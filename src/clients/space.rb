require_relative '../defaultables/space'
require_relative 'client'

module Clients
  class Space < ::Defaultables::Space

    def default_model_class
      Client
    end

  end
end
