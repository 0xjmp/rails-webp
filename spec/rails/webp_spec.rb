require 'spec_helper'

RSpec.describe Rails::WebP do
  describe '#encode_options' do
    subject { described_class.encode_options }

    it { is_expected.not_to be_nil }
  end

  describe '#force' do
    subject { described_class.force }

    it { is_expected.not_to be_nil }
  end
end
