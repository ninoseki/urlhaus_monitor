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
      raise ArgumentError, "#{line} is not valid." unless parts.length == 8

      @date_added = parts.shift
      @url = parts.shift
      @url_status = parts.shift
      @threat = parts.shift
      @host = parts.shift
      @ip_address = parts.shift
      @asnumber = parts.shift
      @country = parts.shift
    end

    def defanged_url
      @defanged_url ||= url.gsub(/\./, "[.]")
    end

    def defanged_host
      @defanged_host ||=  host.gsub(/\./, "[.]")
    end

    def vt_link
      "https://www.virustotal.com/#/domain/#{host}"
    end

    def urlhaus_link
      "https://urlhaus.abuse.ch/host/#{host}/"
    end

    def title
      "#{defanged_url} (#{defanged_host} / #{ip_address}) (#{date_added})"
    end

    def to_attachements
      [
        {
          fallback: "urlhaus link",
          title: defanged_host,
          title_link: urlhaus_link,
          footer: "urlhaus.abuse.ch",
          footer_icon: "http://www.google.com/s2/favicons?domain=urlhaus.abuse.ch"
        },
        {
          fallback: "vt link",
          title: defanged_host,
          title_link: vt_link,
          footer: "virustotal.com",
          footer_icon: "http://www.google.com/s2/favicons?domain=virustotal.com"
        }
      ]
    end
  end
end
