require "logger"
require "logger_plus/additional_data_logger"

RSpec.describe LoggerPlus::AdditionalDataLogger do
  class TestLogger
    extend LoggerPlus::AdditionalDataLogger
    attr_accessor :progname

    def initialize(progname = nil)
      @progname = progname
    end

    def add(severity, progname, &block)
    end
  end

  shared_examples_for "an expected log message" do |severity, expected_message|
    it "calls :add with the expected arguments" do
      expect(logger).to receive(:add).with(::Logger.const_get(severity.to_s.upcase), expected_message, nil)
    end

    context "with a progname set" do
      let(:logger) { TestLogger.new("progname") }

      it "calls :add with the expected arguments" do
        expect(logger).to receive(:add).with(::Logger.const_get(severity.to_s.upcase), expected_message, "progname")
      end
    end
  end

  shared_examples_for "a logger" do |severity|
    let(:logger) { TestLogger.new }
    after { subject }

    context "when a normal message is passed" do
      subject { logger.send(severity, "my message") }

      it_behaves_like "an expected log message", severity, {message: "my message"}
    end

    context "when only hash information is passed" do
      subject { logger.send(severity, hello: :world) }

      it_behaves_like "an expected log message", severity, {hello: :world}
    end

    context "when a message and hash information is passed" do
      subject { logger.send(severity, "my message", hello: :world) }

      it_behaves_like "an expected log message", severity, {message: "my message", hello: :world}
    end

    context "when a block is passed" do
      subject { logger.send(severity) { "hello world" } }

      it_behaves_like "an expected log message", severity, {message: "hello world"}
    end

    context "when hash information and a block is passed" do
      subject { logger.send(severity, hello: :again) { "hello world" } }

      it_behaves_like "an expected log message", severity, {message: "hello world", hello: :again}
    end

    context "when a progname is set with a block" do
      subject { logger.send(severity, "my program") { "hello world" } }

      it "calls :add with the expected arguments" do
        expect(logger).to receive(:add).with(::Logger.const_get(severity.to_s.upcase), {message: "hello world"}, "my program")
      end
    end

    context "when a progname is set with a block and hash information" do
      subject { logger.send(severity, "my program", all: :options) { "hello world" } }

      it "calls :add with the expected arguments" do
        expect(logger).to receive(:add).with(::Logger.const_get(severity.to_s.upcase), {message: "hello world", all: :options}, "my program")
      end
    end
  end

  [
    :debug,
    :info,
    :warn,
    :error,
    :fatal,
    :unknown
  ].each do |severity|
    context severity.to_s do
      it_behaves_like "a logger", severity
    end
  end
end
