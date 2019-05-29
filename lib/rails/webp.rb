require "rails/webp/version"

require 'rails/webp/converter'
require 'rails/webp/post_processor'
require 'rails/webp/railtie'

module Rails
  module WebP
    class Error < StandardError; end

    class << self
      attr_writer :encode_options, :exclude_dir_regex, :force

      def encode_options
        @encode_options ||= { quality: 80, lossless: true, method: 6, alpha_filtering: 2, alpha_compression: 0, alpha_quality: 100 }
      end

      def exclude_dir_regex
        @exclude_dir_regex ||= nil
      end

      # Source assets that are unchanged will not be processed by default.
      # Set this to true if you wish to process webp images anyway.
      def force
        @force ||= false
      end
    end
  end
end
