# frozen_string_literal: true

require "csv"

module URLhausMonitor
  class Entry
    attr_reader :date_added
    attr_reader :url
    attr_reader :url_status
    attr_reader :threat
    attr_reader :host
    attr_reader :ip_address
    attr_reader :asnumber
    attr_reader :country

    def initialize(line)
      parts = CSV.parse(line.chomp).flatten
      raise ArgumentError, "#{line} is not valid." unless parts.length == 8 || parts.length == 9

      if parts.length == 8
        parse_without_tags parts
      else
        parse_with_tags parts
      end
    end

    def defanged_url
      @defanged_url ||= url.gsub(/\./, "[.]")
    end

    def defanged_host
      @defanged_host ||= host.gsub(/\./, "[.]")
    end

    def title
      "#{defanged_url} (#{defanged_host} / #{ip_address} / #{date_added}) : #{threat}"
    end

    def vt_link
      return nil unless _vt_link

      {
        type: "button",
        text: "Lookup on VirusTotal",
        url: _vt_link,
      }
    end

    def urlscan_link
      return nil unless _urlscan_link

      {
        type: "button",
        text: "Lookup on urlscan.io",
        url: _urlscan_link,
      }
    end

    def urlhaus_link
      return nil unless _urlhaus_link

      {
        type: "button",
        text: "Lookup on URLhaus",
        url: _urlhaus_link,
      }
    end

    def actions
      [vt_link, urlscan_link, urlhaus_link].compact
    end

    def to_attachements
      [
        {
          text: defanged_host,
          fallback: "VT & urlscan.io links",
          actions: actions
        }
      ]
    end

    private

    def _vt_link
      "https://www.virustotal.com/#/domain/#{host}"
    end

    def _urlscan_link
      "https://urlscan.io/domain/#{host}"
    end

    def _urlhaus_link
      "https://urlhaus.abuse.ch/host/#{host}/"
    end

    def parse_without_tags(parts)
      @date_added = parts.shift
      @url = parts.shift
      @url_status = parts.shift
      @threat = parts.shift
      @host = parts.shift
      @ip_address = parts.shift
      @asnumber = parts.shift
      @country = parts.shift
    end

    def parse_with_tags(parts)
      @date_added = parts.shift
      @url = parts.shift
      @url_status = parts.shift
      @threat = parts.shift
      @tags = parts.shift
      @host = parts.shift
      @ip_address = parts.shift
      @asnumber = parts.shift
      @country = parts.shift
    end
  end
end
