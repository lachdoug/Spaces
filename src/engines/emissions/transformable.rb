module Emissions
  class Transformable < ::Spaces::Model

    def complete?; true ;end

    def identifier; struct[:identifier] ;end

    def blueprint_identifier; identifier.split('/').last ;end

    def descriptor_class; ::Spaces::Descriptor ;end
    def arena_stanzas; stanzas_for(:arena) ;end
 
    def providers_require; stanzas_for(:arena) ;end

    def provisioning_stanzas; stanzas_for(:provisioning) ;end

    def stanzas_for(symbol); _stanzas_for(symbol) ;end

    def random(length); SecureRandom.hex(length.to_i) ;end

    protected

    def all_complete?(array)
      array.map(&:complete?).all_true?
    end

    private

    def _stanzas_for(symbol)
      raise TransformableWithoutStanzaError
    rescue TransformableWithoutStanzaError => e
      warn(error: e, method: "#{symbol}_stanzas", klass: klass, verbosity: [:silence])
      []
    end

  end
end


class TransformableWithoutStanzaError < StandardError
end
