# frozen_string_literal: true

RSpec.describe URLhausMonitor::Monitor do
  include FakeFS::SpecHelpers

  subject { described_class.new }

  let(:mock) { URLhausMonitor::Checker.new }

  before do
    allow(URLhausMonitor::Checker).to receive(:new).and_return(mock)
    allow(mock).to receive(:lookup).and_return(
      [
        URLhausMonitor::Entry.new('"2019-03-23 08:02:08","http://store.sensyu.org/data/Smarty/config/msg.jpg","online","malware_download","emotet|epoch2","store.sensyu.org","157.7.144.5","7506","JP"'),
      ]
    )
  end

  describe "#lookup_by_country" do
    it do
      output = capture(:stdout) { subject.lookup_by_country("JP") }
      expect(output).to be_a(String)
    end
  end

  describe "#lookup_by_tld" do
    it do
      output = capture(:stdout) { subject.lookup_by_tld("jp") }
      expect(output).to be_a(String)
    end
  end

  describe "#lookup_by_asn" do
    it do
      output = capture(:stdout) { subject.lookup_by_asn("7506") }
      expect(output).to be_a(String)
    end
  end
end
