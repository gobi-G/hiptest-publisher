require 'hiptest-publisher/formatters/reporter'
require 'hiptest-publisher/utils'

module Hiptest
  class VersionChecker
    attr_reader :reporter

    def self.check_version(reporter: nil)
      reporter ||= Reporter.new

      VersionChecker.new(reporter).check_version
    end

    def initialize(reporter)
      @reporter = reporter
    end

    def check_version
      latest = get_latest_version
      return if latest.nil?

      current = hiptest_publisher_version

      if latest == current
        puts 'check_version.up_to_date'
      else
        puts 'check_version.outdated'
      end
    end

    def get_latest_version
      reporter.with_status_message 'check_version.title' do
        latest_gem = Gem.latest_version_for('hiptest-publisher')

        raise RuntimeError, 'check_version.error' if latest_gem.nil?

        latest = latest_gem.version
      end
    end
  end
end
