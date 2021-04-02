RSpec.describe Clint::Linter do
  it "has a version number" do
    expect(Clint::VERSION).not_to be nil
  end

  subject { described_class.new(path) }

  let(:path) { '/spec/support/test_files/Gemfile' }
  let(:urls) do
    {
      "rake" => "https://rubygems.org/downloads/rake-12.0.0.gem",
      "rspec" => "https://rubygems.org/downloads/rspec-3.0.0.gem",
      "bson" => "https://rubygems.org/downloads/bson-4.12.0.gem"
    }
  end

  describe "#gems_with_extensions_list" do
    before do
      allow_any_instance_of(Clint::Builder).to receive(:urls)
        .and_return(urls)
    end

    context "when there is extensions" do
      before do
        allow_any_instance_of(Clint::Checker).to receive(:gems_with_extensions)
          .and_return(['bson'])
      end

      it "returns a list of the gems" do
        expect(subject.gems_with_extensions_list).to eq (['bson'])
      end
    end

    context "when there is no extensions" do
      before do
        allow_any_instance_of(Clint::Checker).to receive(:gems_with_extensions)
          .and_return([])
      end

      it "returns an empty list" do
        expect(subject.gems_with_extensions_list).to eq ([])
      end
    end
  end
end
