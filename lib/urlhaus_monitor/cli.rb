# frozen_string_literal: true

require "thor"

module URLhausMonitor
  class CLI < Thor
    desc "lookup_by_country [COUNTRY]", "lookup by a given country code"
    def lookup_by_country(country)
      Monitor.new.lookup_by_country country
    end

    desc "lookup_by_tld [tld]", "lookup by a given tld"
    def lookup_by_tld(tld)
      Monitor.new.lookup_by_tld tld
    end

    desc "lookup_by_asn [asn]", "lookup by a given asn"
    def lookup_by_asn(asn)
      Monitor.new.lookup_by_asn asn
    end
  end
end
