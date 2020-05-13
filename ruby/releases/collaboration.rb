require_relative '../spaces/model'

module Releases
  class Collaboration < ::Spaces::Model

    relation_accessor :predecessor

    delegate([:outline, :collaborating_divisions] => :schema)

    def memento; OpenStruct.new(to_h) ;end

    def divisions; division_map.values ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m[k] = division_for(k)
        m
      end.compact
    end

    def division_for(key)
      collaborating_divisions[key]&.prototype(collaboration: self, label: key)
    end

    def to_h
      keys.inject({}) do |m, k|
        m[k] = memento_for(k)
        m
      end.compact
    end

    def memento_for(key)
      division_map[key]&.memento || struct[key]
    end

    def schema_keys; schema.keys ;end
    def division_keys; division_map.keys ;end

    def method_missing(m, *args, &block)
      if division_keys.include?(m)
        division_map[m.to_sym] || struct[m]
      else
        super
      end
    end

  end
end
