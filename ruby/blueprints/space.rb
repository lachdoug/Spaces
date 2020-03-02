require_relative '../universal/space'
require_relative '../spaces/static_space'
require_relative 'blueprint'

module Blueprints
  class Space < ::Spaces::StaticSpace

    def new_for(descriptor)
      model_class.new(open_struct_from_json(outer.by(descriptor))).tap do |m|
        m.struct.descriptor = descriptor
      end
    end

    def by(descriptor)
      f = File.open("#{file_name_for(descriptor)}.yaml", 'r')
      begin
        model_class.new(model_class.from_yaml(f.read))
      ensure
        f.close
      end
    end

    def import(descriptor)
      outer.import(descriptor)
      new_for(descriptor).tap do |m|
        save_yaml(m)
        import_anchors_for(m)
      end
    end

    def import_anchors_for(model)
      unimported_anchors_for(model).each { |d| import(d) }
    end

    def unimported_anchors_for(model)
      model.anchor_descriptors&.reject { |d| imported?(d) } || []
    end

    def file_name_for(descriptor)
      ensure_subspace_for(descriptor)
      "#{subspace_path_for(descriptor)}/#{model_class.qualifier}"
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(subspace_path_for(descriptor))
    end

    def text_file_names_for(descriptor)
      outer.text_file_names_for(descriptor)
    end

    def imported?(descriptor)
      Dir.exist?(subspace_path_for(descriptor))
    end

    def model_class
      Blueprint
    end

    def outer
      universe.outer
    end
  end
end
