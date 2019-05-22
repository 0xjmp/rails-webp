module Rails
  module WebP
    class PostProcessor
      def initialize(filename, &block)
        @filename = filename
        @source   = block.call
      end

      def render(context, empty_hash_wtf)
        self.class.run(@filename, @source, context)
      end

      def self.run(filename, data, context)
        Converter.process(filename, data, context)
      end

      def self.call(input)
        filename = input[:filename]
        source   = input[:data]
        context  = input[:environment].context_class.new(input)

        result = run(filename, source, context)
        context.metadata.merge(data: result)
      end
    end
  end
end
