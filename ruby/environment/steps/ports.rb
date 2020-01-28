require_relative 'requires'

module Environment
  class Environment
    class Ports < Docker::File::Step

      def content
        [
          worker_ports,
          ports.map { |p| expose(p)}
        ]
      end

      def expose(port)
        "EXPOSE #{port.port}"
      end

      def worker_ports
        "ENV WorkerPorts '#{ports.map { |p| p.port }.compact.join(' ')}'"
      end

      def ports
        @ports ||= context.ports || []
      end

    end
  end
end
