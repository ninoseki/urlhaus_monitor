# frozen_string_literal: true

require "http"

module URLhausMonitor
  class Checker
    BASE_URL = "https://urlhaus.abuse.ch"
    LIMIT = 50

    def lookup_by_country(country)
      lookup "#{BASE_URL}/feeds/country/#{country}"
    end

    def lookup_by_tld(tld)
      lookup "#{BASE_URL}/feeds/tld/#{tld}"
    end

    def lookup_by_asn(asn)
      lookup "#{BASE_URL}/feeds/asn/#{asn}"
    end

    private

    def lookup(url)
      res = HTTP.get(url)
      return nil unless res.code == 200

      convert res.body.to_s.lines[0..LIMIT]
    end

    def convert(lines)
      [].tap do |entries|
        lines.each do |line|
          next if line.start_with? "#"

          entries << Entry.new(line)
        end
      end
    end
  end
end
