require 'fileutils'
require 'logger'
require 'mini_magick'

module Rails
  module WebP
    class Converter
      class << self
        attr_reader :context

        def convert_to_webp(input_path, output_path)
          # Ex: convert wizard.png -quality 50 -define webp:lossless=true wizard.webp
          MiniMagick::Tool::Convert.new do |convert|
            convert << input_path
            options = WebP.encode_options
            convert << '-quality' << options[:quality]
            options.except(:quality).each do |name, value|
              convert << "-define" << "webp:#{name.to_s.dasherize}=#{value}"
            end
            convert << output_path
          end
        end

        def process(input_path, data, context, app = Rails.application)
          return data if excluded_dir?(input_path)
          @context = context
          prefix = app.config.assets.prefix
          digest = data_digest(data)
          webp_file = webp_file_name(data, digest)
          output_path = Pathname.new(File.join(app.root, 'public', prefix, webp_file))
          if WebP.force || !webp_file_exists?(digest, output_path)
            FileUtils.mkdir_p(output_path.dirname) unless Dir.exists?(output_path.dirname)
            # TODO: check app.assets.gzip and act accordingly
            convert_to_webp(input_path, output_path)
            logger&.info "Writing #{output_path}"
          end
          data
        end

        private

        def data_digest(data)
          "-#{context.environment.digest_class.new.update(data).to_s}"
        end

        def excluded_dir?(path)
          regex = WebP.exclude_dir_regex
          return false unless regex
          !!path.match(regex)
        end

        def webp_file_name(data, digest)
          file_name = context.logical_path # Original File name w/o extension
          file_ext  = File.extname(context.filename) # Original File extension
          "#{file_name}#{digest}.webp" # WebP File fullname
        end

        def webp_file_exists?(digest, output_path)
          File.exists?(output_path) && digest == output_path.to_s.split('-').last.split('.').first
        end

        def logger
          if context && context.environment
            context.environment.logger
          else
            logger = Logger.new($stderr)
            logger.level = Logger::FATAL
            logger
          end
        end
      end
    end
  end
end
