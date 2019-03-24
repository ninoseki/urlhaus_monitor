# frozen_string_literal: true

RSpec.describe URLhausMonitor::Entry do
  subject {
    URLhausMonitor::Entry.new '"2019-03-23 08:02:08","http://store.sensyu.org/data/Smarty/config/msg.jpg","online","malware_download","store.sensyu.org","157.7.144.5","7506","JP"'
  }

  it "should have date_added" do
    expect(subject.date_added).to eq("2019-03-23 08:02:08")
  end

  it "should have url" do
    expect(subject.url).to eq("http://store.sensyu.org/data/Smarty/config/msg.jpg")
  end

  it "should have url_status" do
    expect(subject.url_status).to eq("online")
  end

  it "should have threat" do
    expect(subject.threat).to eq("malware_download")
  end

  it "should have host" do
    expect(subject.host).to eq("store.sensyu.org")
  end

  it "should have ip_address" do
    expect(subject.ip_address).to eq("157.7.144.5")
  end

  it "should have asnumber" do
    expect(subject.asnumber).to eq("7506")
  end

  it "should have country" do
    expect(subject.country).to eq("JP")
  end

  describe "#defanged_url" do
    it "should reeturn a defanged url" do
      expect(subject.defanged_url).to eq("http://store[.]sensyu[.]org/data/Smarty/config/msg[.]jpg")
    end
  end

  describe "#defanged_host" do
    it "should reeturn a defanged host" do
      expect(subject.defanged_host).to eq("store[.]sensyu[.]org")
    end
  end

  describe "#to_attachements" do
    it "should reeturn a defanged url" do
      attachements = subject.to_attachements
      attachements.each do |attachement|
        expect(attachement.dig(:title)).to be_a(String)
      end
    end
  end
end
