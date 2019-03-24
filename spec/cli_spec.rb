# frozen_string_literal: true

RSpec.describe URLhausMonitor::CLI do
  subject { URLhausMonitor::CLI }

  describe "#lookup_by_country" do
    before do
      allow(URLhausMonitor::Monitor).to receive_message_chain(:new, :lookup_by_country)
    end

    it do
      subject.start %w(lookup_by_country JP)
      expect(URLhausMonitor::Monitor.new).to have_received(:lookup_by_country).once
    end
  end

  describe "#lookup_by_tld" do
    before do
      allow(URLhausMonitor::Monitor).to receive_message_chain(:new, :lookup_by_tld)
    end

    it do
      subject.start %w(lookup_by_tld jp)
      expect(URLhausMonitor::Monitor.new).to have_received(:lookup_by_tld).once
    end
  end

  describe "#lookup_by_asn" do
    before do
      allow(URLhausMonitor::Monitor).to receive_message_chain(:new, :lookup_by_asn)
    end

    it do
      subject.start %w(lookup_by_asn 7506)
      expect(URLhausMonitor::Monitor.new).to have_received(:lookup_by_asn).once
    end
  end
end
