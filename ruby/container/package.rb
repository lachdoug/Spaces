require_relative '../spaces/model'
require_relative 'docker_file_layering'

module Container
  class Package < ::Spaces::Model

    def installation
      %Q(
        echo "#App Archives" && \
        #{script} '#{download_type}' '#{source}' '#{name}' '#{extraction}' '#{destination}'  '#{extraction_path}'  '#{options}' && \
      )
    end

    def script
      '/scripts/package_installer.sh'
    end

    def download_type
      descriptor.extension
    end

    def source
      descriptor.value
    end

    def name
      descriptor.identifier
    end

    def extraction
      descriptor.extraction
    end

    def destination
      '/home/app'
    end

    def extraction_path
      descriptor.identifier
    end

    def options
      ''
    end

    def initialize(descriptor)
      self.descriptor = descriptor
    end

  end
end
