require 'spec_helper'

describe "default feed xml parser" do
  context "0.5.1 (used by API v2)" do
    it "should convert into attributes hash" do
      @xml = feed_as_(:xml)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank location" do
      @xml = feed_as_(:xml, :except_node => :location)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank units" do
      @xml = feed_as_(:xml, :except_node => :unit)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle missing unit attributes" do
      @xml = feed_as_(:xml, :except_node => :unit_attributes)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank tags" do
      @xml = feed_as_(:xml, :except_node => :tag)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should gracefully handle 0.5.1 xml missing the base environment node" do
      xml = <<-EOXML
<?xml version="1.0" encoding="UTF-8"?>
<eeml xmlns="http://www.eeml.org/xsd/0.5.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="0.5.1" xsi:schemaLocation="http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd">
  <title>ohai</title>
</eeml>
EOXML
      expect {
        Cosm::Feed.new(xml)
      }.to raise_error(Cosm::Parsers::XML::InvalidXMLError)
    end

  end

  context "5 (used by API v1)" do
    it "should convert into attributes hash" do
      @xml = feed_as_(:xml, :version => "5")
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank tags" do
      @xml = feed_as_(:xml, :version => "5", :except_node => :tag)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank location" do
      @xml = feed_as_(:xml, :version => "5", :except_node => :location)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle blank units" do
      @xml = feed_as_(:xml, :version => "5", :except_node => :unit)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle missing unit attributes" do
      @xml = feed_as_(:xml, :version => "5", :except_node => :unit_attributes)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should handle missing value attributes" do
      @xml = feed_as_(:xml, :version => "5", :except_node => :value_attributes)
      Cosm::Feed.new(@xml).should fully_represent_feed(:xml, @xml)
    end

    it "should gracefully handle 0.5.1 xml missing the base environment node" do
      xml = <<-EOXML
<?xml version="1.0" encoding="UTF-8"?>
<eeml xmlns="http://www.eeml.org/xsd/005" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="5" xsi:schemaLocation="http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd"> 
  <title>ohai</title>
</eeml>
EOXML
      expect {
        Cosm::Feed.new(xml)
      }.to raise_error(Cosm::Parsers::XML::InvalidXMLError)
    end

  end
end

