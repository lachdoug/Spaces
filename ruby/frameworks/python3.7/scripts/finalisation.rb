require_relative '../../../texts/script'

module Frameworks
  module Python37
    module Scripts
      class Finalisation < Texts::Script

        def body
          %Q(
          mkdir  -p /var/log/apache2/
          chown www-data /var/log/apache2/
          mkdir  -p /run/apache2/
          chown www-data /run/apache2/
          )
        end

        def identifier
          'finalisation'
        end

      end
    end
  end
end