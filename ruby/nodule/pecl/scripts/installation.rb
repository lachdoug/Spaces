require_relative '../../../spaces/script'

module Nodule
  class PECL
    class Installation < Spaces::Script

      def body
        "echo \"  \" |  pecl install #{context.name}"
      end

    end
  end
end
