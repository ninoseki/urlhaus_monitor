# frozen_string_literal: true

RSpec.describe URLhausMonitor::Checker, :vcr do
  subject { URLhausMonitor::Checker.new }

  describe "#lookup_by_country" do
    let(:entries) { subject.lookup_by_country("JP") }

    it do
      entries.each { |entry| expect(entry).to be_a(URLhausMonitor::Entry) }
    end
  end

  describe "#lookup_by_tld" do
    let(:entries) { subject.lookup_by_tld("jp") }

    it do
      entries.each { |entry| expect(entry).to be_a(URLhausMonitor::Entry) }
    end
  end

  describe "#lookup_by_asn" do
    let(:entries) { subject.lookup_by_asn("7506") }

    it do
      entries.each { |entry| expect(entry).to be_a(URLhausMonitor::Entry) }
    end
  end
end
