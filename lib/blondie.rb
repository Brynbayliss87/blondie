require "blondie/version"
require "blondie/builder"
require "blondie/checker"
require 'pathname'

module Blondie
  class Linter

    attr_reader :gemfile_path

    def initialize(path)
      @gemfile_path = path
    end

    def gems_with_extensions_list
      builder = Blondie::Builder.new(gemfile_path)
      checker = Blondie::Checker.new(builder.urls)
      checker.gems_with_extensions
    end
  end
end
