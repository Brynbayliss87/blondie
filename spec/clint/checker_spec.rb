RSpec.describe Clint::Checker do
  subject do
    described_class.new(urls)
  end

  let(:urls) do
    {
      "rake" => "https://rubygems.org/downloads/rake-12.0.0.gem",
      "rspec" => "https://rubygems.org/downloads/rspec-3.0.0.gem",
      "bson" => "https://rubygems.org/downloads/bson-4.12.0.gem"
    }
  end

  describe "#extensions" do
    context "when a gem has an extension" do
      specify { expect(subject.extensions).to eq(["ext/bson/extconf.rb"]) }
    end

    context "when no dependency has a c extension" do
      let(:urls) do
        {
          "rake" => "https://rubygems.org/downloads/rake-12.0.0.gem",
          "rspec" => "https://rubygems.org/downloads/rspec-3.0.0.gem"
        }
      end

      specify { expect(subject.extensions).to eq([]) }
    end
  end

  describe "#gems_with_extensions" do
    context "when a gem has an extension" do
      specify { expect(subject.gems_with_extensions).to eq(["bson"]) }
    end

    context "when no dependency has a c extension" do
      let(:urls) do
        {
          "rake" => "https://rubygems.org/downloads/rake-12.0.0.gem",
          "rspec" => "https://rubygems.org/downloads/rspec-3.0.0.gem"
        }
      end

      specify { expect(subject.gems_with_extensions).to eq([]) }
    end
  end
end

