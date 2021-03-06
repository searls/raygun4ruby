require_relative '../spec_helper'
require 'stringio'

describe Raygun do
  let(:failsafe_logger) { FakeLogger.new }

  describe '#track_exception' do
    context 'send in background' do
      before do
        Raygun.setup do |c|
          c.send_in_background = true
          c.api_url = 'http://example.api'
          c.api_key = 'foo'
          c.debug = true
          c.failsafe_logger = failsafe_logger
        end
      end

      context 'request times out' do
        before do
          stub_request(:post, 'http://example.api/entries').to_timeout
        end

        it 'logs the failure to the failsafe logger' do
          error = StandardError.new

          Raygun.track_exception(error)

          # Occasionally doesn't write to the failsafe logger, add small timeout to add some safety
          sleep 0.1
          failsafe_logger.get.must_match /Problem reporting exception to Raygun/
        end
      end
    end
  end

  describe '#reset_configuration' do
    it 'clears any customized configuration options' do
      Raygun.setup do |c|
        c.api_url = 'http://test.api'
      end

      Raygun.configuration.api_url.must_equal 'http://test.api'

      Raygun.reset_configuration

      Raygun.configuration.api_url.must_equal Raygun.default_configuration.api_url
    end
  end
end
