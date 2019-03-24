# frozen_string_literal: true

require "lightly"

module URLhausMonitor
  class Monitor
    attr_reader :checker
    attr_reader :cache

    def initialize
      @checker = Checker.new
      @cache = Lightly.new(dir: "/tmp/urlhause_monitor", life: "180d")
    end

    def lookup_by_country(country)
      entries = checker.lookup_by_country(country)
      process entries
    end

    def lookup_by_tld(tld)
      entries = checker.lookup_by_tld(tld)
      process entries
    end

    def lookup_by_asn(asn)
      entries = checker.lookup_by_asn(asn)
      process entries
    end

    def process(entries)
      return nil unless entries

      entries.each do |entry|
        next if cache.cached? entry.url

        Notifier.notify entry.title, entry.to_attachements
        cache.save entry.url, true
      end
    end
  end
end
