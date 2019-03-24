# frozen_string_literal: true

require "urlhaus_monitor/version"

require "urlhaus_monitor/entry"
require "urlhaus_monitor/checker"
require "urlhaus_monitor/notifier"
require "urlhaus_monitor/monitor"
require "urlhaus_monitor/cli"

module URLhausMonitor
  class Error < StandardError; end
end
