RSpec.describe Clint::Builder do
  subject do
    described_class.new(
      Bundler.root.to_s + testfile_path
    )
  end

  describe '#urls' do
    let(:testfile_path) { '/spec/support/test_files/Gemfile'}

    it "returns a hash of correctly versioned gem urls from the gemfile" do
      expected = {
        "rake" => "https://rubygems.org/downloads/rake-12.0",
        "rspec" => "https://rubygems.org/downloads/rspec-3.0",
        "bson" => "https://rubygems.org/downloads/bson-",
        "pry" => "https://rubygems.org/downloads/pry-"
      }

      expect(subject.urls.keys).to match_array(expected.keys)
      expect(subject.urls["rake"]).to include(expected["rake"])
      expect(subject.urls["rspec"]).to include(expected["rspec"])
      expect(subject.urls["bson"]).to include(expected["bson"])
      expect(subject.urls["pry"].split("/").last).not_to include("ruby", "java", "i386-mingw32", "i386-mswin32")
    end

    context "with a non-existant version number and specifier" do
      let(:testfile_path) { '/spec/support/test_files/invalid_version/Gemfile'}

      it "raises an error" do
        expect{subject.urls}.to raise_error {'gem version does not exist'}
      end
    end
  end
end
