require_relative '../container'

module Provisioning
  module Containers
    module LXD
      class LXD < Container

        class << self
          def inheritance_paths; __dir__ ;end
        end

        require_files_in :stanzas

      end
    end
  end
end
