require "logger"

require "logger_plus/version"
require "logger_plus/additional_data_logger"

module LoggerPlus
  class Logger < ::Logger
    extend AdditionalDataLogger
  end

  if Object.const_defined?("LogStashLogger::MultiLogger")
    class ::LogStashLogger::MultiLogger
      extend AdditionalDataLogger
    end
  end
end
