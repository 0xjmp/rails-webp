require 'spec_helper'

RSpec.describe Rails::WebP::Converter do
  let(:input_path) { File.join('spec', 'fixtures', 'test.jpg') }

  before do
    File.delete(output_path) if File.exists?(output_path)
    # Dir.delete(File.join('spec/fixtures/public'))
  end

  describe '#convert_to_webp' do
    let(:output_path) { File.join('spec', 'fixtures', 'test.webp') }

    subject { described_class.convert_to_webp(input_path, output_path) }

    it { is_expected_block.to change { File.exists?(output_path) }.from(false).to(true) }
  end

  describe '#process' do
    let(:application) do
      OpenStruct.new(
        config: OpenStruct.new(
          assets: OpenStruct.new(
            prefix: '',
          ),
        ),
        root: 'spec/fixtures/',
      )
    end
    let(:context) do
      class DummyDigestClass
        def update(_)
          'this-is-permanent'
        end
      end
      OpenStruct.new(
        environment: OpenStruct.new(
          digest_class: DummyDigestClass,
        ),
        logical_path: 'test',
        pathname: OpenStruct.new(
          extname: 'webp',
        ),
      )
    end
    let(:data) { File.read(input_path) }
    let(:output_path) { File.join('spec', 'fixtures', 'public', 'test-this-is-permanent.webp') }

    subject { described_class.process(input_path, data, context, application) }

    it { is_expected_block.to change { File.exists?(output_path) }.from(false).to(true) }
  end
end
