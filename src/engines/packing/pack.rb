module Packing
  class Pack < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end

      def script_choices(script_type)
        Pathname.glob("#{__dir__}/scripts/#{script_type}/*")
      end

      def script_choices_names(script_type)
        script_choices(script_type).map(&:basename).map(&:to_s).map(&:to_sym)
      end

      def script_type_choices
        Pathname.glob("#{__dir__}/scripts/*").map(&:basename).map(&:to_s).map(&:to_sym)
      end
    end

    delegate(
      [
        :identifier, :has?,
        :images, :os_packages, :binding_descriptors,
        :division_scripts_for, :packing_script_file_names, :blueprint_scripts, :injections
      ] => :resolution,
      post_processor_stanzas: :images
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :composition_keys

    def export; struct_for(images.all.map(&:export)) ;end
    def emit; super.merge(struct_for(images.all.map(&:commit))) ;end

    def struct_for(images)
      OpenStruct.new(
        builders: images&.tap do |i|
          i.each { |s| s.delete_field(:scripts) if s.dig(:scripts) }
        end
      )
    end

    def auxiliary_files
      [division_scripts, blueprint_scripts, injections].flatten
    end

    def division_scripts; division_scripts_for(packing_script_file_names) ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.emit.images)
      self.struct.identifier = resolution.identifier
      self.resolution = resolution
    end

  end
end
