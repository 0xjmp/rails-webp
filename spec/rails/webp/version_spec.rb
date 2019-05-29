require 'spec_helper'

RSpec.describe Rails::WebP do
  subject { described_class::VERSION }

  it { is_expected.not_to be_nil }
end
