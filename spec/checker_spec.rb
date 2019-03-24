# frozen_string_literal: true

RSpec.describe URLhausMonitor::Checker, :vcr do
  subject { URLhausMonitor::Checker.new }

  describe "#lookup_by_country" do
    it "should return an array of Entry" do
      entries = subject.lookup_by_country("JP")
      expect(entries).to be_an(Array)
      expect(entries.first).to be_a(URLhausMonitor::Entry)
    end
  end

  describe "#lookup_by_tld" do
    it "should return an array of Entry" do
      entries = subject.lookup_by_tld("jp")
      expect(entries).to be_an(Array)
      expect(entries.first).to be_a(URLhausMonitor::Entry)
    end
  end

  describe "#lookup_by_asn" do
    it "should return an array of Entry" do
      entries = subject.lookup_by_asn("7506")
      expect(entries).to be_an(Array)
      expect(entries.first).to be_a(URLhausMonitor::Entry)
    end
  end
end
