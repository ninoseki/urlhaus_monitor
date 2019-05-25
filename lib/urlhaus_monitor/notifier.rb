# frozen_string_literal: true

require "slack/incoming/webhooks"

module URLhausMonitor
  class Notifier
    def notifiy(title, attachments = [])
      attachments << { title: "N/A" } if attachments.empty?

      if slack_webhook_url?
        slack = Slack::Incoming::Webhooks.new(slack_webhook_url, channel: slack_channel)
        slack.post title, attachments: attachments
      else
        puts title
      end
    end

    def slack_webhook_url
      ENV.fetch "SLACK_WEBHOOK_URL"
    end

    def slack_channel
      ENV.fetch "SLACK_CHANNEL", "#general"
    end

    def slack_webhook_url?
      ENV.key? "SLACK_WEBHOOK_URL"
    end

    def self.notify(title, attachments)
      new.notifiy(title, attachments)
    end
  end
end
