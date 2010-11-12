require File.expand_path('../spec_helper', __FILE__)

describe Open311, ".service_list" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://api.dc.org/open311/v2_dev/'
      config.format       = 'xml'
      config.jurisdiction = 'dc.gov'
      config.lat = '38.888486'
      config.long = '-77.020179'
    end
    stub_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      to_return(:body => fixture('services.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_list
    a_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = Open311.service_list
    services.should be_an Array
    services.first.service_code.should == '001'
  end
end

describe Open311, ".service_definition" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.format       = 'xml'
      config.jurisdiction = 'dc.gov'
      config.lat = '38.888486'
      config.long = '-77.020179'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      to_return(:body => fixture('service_definition.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_definition('033')
    a_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      should have_been_made
  end

  it "should return the correct results" do
    service_def = Open311.service_definition('033')
    service_def.should be_an Hash
    service_def.service_code.should == "DMV66"
  end
end
