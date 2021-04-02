require "clint/version"
require "clint/builder"
require "clint/checker"
require 'pathname'

module Clint
  class Linter

    attr_reader :gemfile_path

    def initialize(path = nil)
      @gemfile_path = if path
        generate_path(path)
      else
        File.expand_path(File.dirname(__FILE__)) + "/Gemfile"
      end
    end

    def gems_with_extensions_list
      builder = Clint::Builder.new(gemfile_path)
      checker = Clint::Checker.new(builder.urls)
      checker.gems_with_extensions
    end

    private

    def generate_path(path)
      raise "Gemfile not specified in path" unless path.split("/").last == "Gemfile"
      if (Pathname.new(path)).absolute?
        path
      else
        File.expand_path(path, File.dirname(__FILE__))
      end
    end
  end
end
