require "bundler/setup"
require 'rails/railtie'
require "rails/webp"

module RSpecHelpers
  def is_expected_block
    expect { subject }
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpecHelpers
end
