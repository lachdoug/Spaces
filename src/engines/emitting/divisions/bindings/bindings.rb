module Divisions
  class Bindings < ::Emissions::Divisible

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def resolutions
      all.map(&:resolution)
    end

    def embeds
      all.select(&:embed?).map { |e| [e, embeds_under(e)] }.flatten
    end

    def embeds_under(embed)
      if (b = embed.blueprint).has?(:bindings)
        b.bindings.embeds
      else
        []
      end
    end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
