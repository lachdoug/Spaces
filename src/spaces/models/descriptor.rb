require 'addressable/uri'

require_relative 'model'

module Spaces
  class Descriptor < Model

    class << self
      def inflatables; [:identifier, :repository, :branch, :protocol] ;end
    end

    attr_accessor :repository

    def identifier; struct.identifier || defaults[:identifier] ;end

    def branch; struct.branch || defaults[:branch] ;end
    def protocol; struct.protocol || defaults[:protocol] ;end
    def git?; protocol == 'git' ;end

    def defaults
      @defaults = {
        identifier: root_identifier,
        branch: 'main',
        protocol: extname&.gsub('.', '')
      }
    end

    def root_identifier; basename&.split('.')&.first ;end
    def basename; repository&.basename ;end
    def extname; repository&.extname ;end

    def initialize(args)
      self.repository = Addressable::URI.parse(args[:repository] || args[:struct]&.repository)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

    def to_s
      [repository, branch, identifier].compact.join(' ')
    end

  end
end
