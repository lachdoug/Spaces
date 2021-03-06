require_relative '../spaces/models/composition'
require_relative 'associations/dns/dns'

module Provisioning
  class Composition < ::Spaces::Composition

    class << self
      def associative_classes
        [
          Dns::Dns
        ]
      end

      def divisions; @divisions ||= map_for(associative_classes) ;end

      def mandatory_keys; divisions.keys ;end
    end

    delegate(mandatory_keys: :klass)

  end
end
