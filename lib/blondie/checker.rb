          require 'pry'
require 'tmpdir'
require 'yaml'
require 'minitar'

module Blondie
  class Checker

    attr_reader :urls

    def initialize(urls)
      @urls = urls
      @extensions = []
      @gems_with_extensions = []
    end

    def gems_with_extensions
      find_extensions if @gems_with_extensions.empty?
      @gems_with_extensions
    end

    def extensions
      find_extensions if @extensions.empty?
      @extensions
    end

    private

    def find_extensions
      Dir.mktmpdir do |directory|
        urls.each do |gem_name, url|
          filename = url.split("/").last
          create_tempfile(url, directory, filename)

          Minitar.unpack("#{directory}/#{filename}", "#{directory}/gem_tar")

          metadata = "#{directory}/gem_tar/metadata.gz"
          check_metadata(metadata, gem_name)
        end
      end
    end

    def check_metadata(metadata, gem_name)
      c_extensions = Zlib::GzipReader.open(metadata) do |gz|
        YAML.load(gz.read)
       end.extensions

       if !c_extensions.empty?
         @extensions += c_extensions
         @gems_with_extensions << gem_name
       end
    end

    def create_tempfile(url, directory, filename)
      File.open("#{directory}/#{filename}", "w") do |f|
        f.write(URI.open(url).read)
      end
    end
  end
end
