require_relative '../../installations/division'
require_relative '../../texts/text'
require_relative 'group_precedence'

module Docker
  module Files
    class File < ::Installations::Division
      extend GroupPrecedence

      class << self
        def step_precedence
          {
            early: [:adds],
            late: [:preparations, :source_persistence],
            last: [:final]
          }
        end

        def inheritance_paths; __dir__ ;end
      end

      require_files_in :steps

      delegate(group_precedence: :klass)

      def instructions
        text_class.new(origin: origin, context: self).resolution
      end

      alias_method :content, :instructions

      def origin
        layers.flatten.compact.join("\n")
      end

      def layers
        group_precedence.map do |g|
          related_divisions.map { |c| c.layers_for(g) }
        end
      end

      def text_class; Texts::Text ;end
      def installation_path; klass.identifier ;end

    end
  end
end
