require "logger"

module LoggerPlus
  module AdditionalDataLogger
    def self.extended(base)
      [
        :debug,
        :info,
        :warn,
        :error,
        :fatal,
        :unknown
      ].each do |method_name|
        base.class_eval %Q{
          def #{method_name.to_s}(progname = nil, **additional_data, &block)
            add_plus(::Logger::#{method_name.to_s.upcase}, progname, additional_data, &block)
          end
        }
      end

      base.class_eval do
        private
        #
        # Given the additional data, perform some magic on the message before it gets passed up
        # to the actual logger to include the additional data
        #
        def add_plus(severity, progname, additional_data, &block)
          if block_given?
            message = yield
            progname ||= @progname
          else
            message = progname
            progname = @progname
          end


          message = if message.is_a?(String)
            message.strip.empty? ? nil : message.strip
          else
            message
          end

          add(severity, additional_data.merge(message: message).reject { |_, v| v.nil? }, progname)
        end
      end
    end
  end
end
