require "clint/version"
require "clint/builder"
require "clint/checker"
require 'pathname'

module Clint
  class Linter

    attr_reader :gemfile_path

    def initialize(path)
      @gemfile_path = path
    end

    def gems_with_extensions_list
      builder = Clint::Builder.new(gemfile_path)
      checker = Clint::Checker.new(builder.urls)
      checker.gems_with_extensions
    end
  end
end
