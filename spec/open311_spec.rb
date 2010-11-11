require File.expand_path('../spec_helper', __FILE__)

describe Open311, ".service_list" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'https://open311.sfgov.org/'
      config.format       = 'xml'
      config.jurisdiction = 'sfgov.org'
    end
    stub_request(:get, 'https://open311.sfgov.org/dev/v2/services.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
      to_return(:body => fixture('services.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_list
    a_request(:get, 'https://open311.sfgov.org/dev/v2/services.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
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
      config.endpoint     = 'https://open311.sfgov.org/'
      config.format       = 'xml'
      config.jurisdiction = 'sfgov.org'
    end
    stub_request(:get, 'https://open311.sfgov.org/dev/v2/services/033.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
      to_return(:body => fixture('service_definition.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_definition('033')
    a_request(:get, 'https://open311.sfgov.org/dev/v2/services/033.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
      should have_been_made
  end

  it "should return the correct results" do
    service_def = Open311.service_definition('033')
    service_def.should be_an Hash
    service_def.service_code.should == "DMV66"
  end
end
