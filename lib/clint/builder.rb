require "open-uri"
require "yaml"

module Clint
  class Builder
    RUBY_GEMS_URL = "https://rubygems.org/downloads/".freeze

    attr_reader :gemfile_path

    def initialize(gemfile_path)
      @gemfile_path = gemfile_path
    end

    def urls
      @urls ||= {}.tap do |hash|
        gems_hash.each do |key, value|
          version = value.last&.gsub(/\"|'/, "")
          specifier = value.first.gsub(/\"|'/, "") if value.count == 2
          specifier&.gsub!("\"", "")
          library = key.gsub(/('|,|")/, "")
          url = "#{RUBY_GEMS_URL}#{library}"
          url += versioned_url(library, specifier, version)
          hash[library] = url
        end
      end
    end

    private

    def versioned_url(library, specifier, version)
      return "-#{version}.gem" if version && !specifier_greater?(specifier)

      "-#{resolve_latest_version(library, specifier, version)}.gem"
    end

    def resolve_latest_version(library, specifier, version)
      version += ".0" if version&.count(".") == 1
      version += ".0.0" if version && version.count(".") == 0
      versions = `gem search ^#{library}$  --remote --all`
      versions = versions.split(",")
      versions = clean_up_versions(versions)

      case specifier
      when ">", ">=", nil
        versions.first
      when "~>"
        versions.each_with_index do |v, index|
          next_ver = if index == 0
                       versions[index]
                     else
                       versions[index - 1]
                     end
          if v == version
            return next_ver unless version_bump?(v, next_ver)
            return v
          end
        end
        raise 'gem version does not exist'
      end
    end

    def clean_up_versions(versions)
      versions.delete_at(0)
      versions = versions.select do |v|
        v.strip!
        !v.include?("ruby") && (
          v.include?("java") ||
          v.include?("i386-mingw32") ||
          v.include?("i386-mswin32")
        ) || (
              !v.include?("ruby") ||
              !v.include?("java") ||
              !v.include?("i386-mingw32") ||
              !v.include?("i386-mswin32")
             )
      end
      versions.each { |v| v.gsub!(/(\(|\s|\)|,|ruby|java|i386-mingw32|i386-mswin32)/, "")}
    end

    def version_bump?(current_version, next_version)
      return false if current_version[0].to_i == (next_version[0].to_i - 1) && current_version[2] < next_version[2]

      true
    end

    def specifier_greater?(specifier)
      specifier && specifier.match(">")
    end

    def gems_hash
      @gems_hash ||= {}.tap do |hash|
        File.foreach(gemfile_path) do |line|
          deps = line.split(" ")
          if deps&.first&.[](0..3) == "gem"
            next if deps.count > 4
            value = [ deps[2] ]
            value << deps[3]
            hash[deps[1]] = value.compact
          end
        end
      end
    end
  end
end
