require_relative '../models/model'
require_relative 'infix'

module Interpolating
  class Text < ::Spaces::Model

    relation_accessor :division

    attr_accessor :origin

    delegate(emission: :division)

    def resolved; @resolved ||= contains_interpolation? ? with_resolved_infixes : origin ;end

    alias_method :content, :resolved

    def with_resolved_infixes; immutables.zip(infixes.map(&:resolved)).flatten.join ;end

    def contains_interpolation?
      origin.include?(interpolation_marker)
    rescue NoMethodError
      false
    end

    def immutables; splits(:even?) ;end
    def infixes; splits(:odd?).map { |s| infix_class.new(value: s, text: self) } ;end

    def splits(method); origin.split(interpolation_marker).select.with_index { |_, i| i.send(method) } ;end

    def interpolation_marker; '^^' ;end
    def infix_class; Infix ;end
    def to_s; origin ;end

    def initialize(origin:, division:)
      self.division = division
      self.origin = origin
    end

  end
end
