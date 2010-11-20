require 'rubygems'
require 'json'
require File.expand_path('../spec_helper', __FILE__)

describe Open311, ".service_list" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://api.dc.org/open311/v2_dev/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
      to_return(:body => fixture('services.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_list
    a_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
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
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
      to_return(:body => fixture('service_definition.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_definition('033')
    a_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
      should have_been_made
  end

  it "should return the correct results" do
    service_def = Open311.service_definition('033')
    service_def.should be_an Hash
    service_def.service_code.should == "DMV66"
  end
end

describe Open311, ".service_requests" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/requests.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
      to_return(:body => fixture('service_requests.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.service_requests
    a_request(:get, 'http://blasius.ws:3003/open311/requests.xml').
      with(:query => {:jurisdiction_id => 'dc.gov'}).
      should have_been_made
  end

  it "should return the correct results" do
    service_requests = Open311.service_requests
    service_requests.should be_an Array
    service_requests.length.should == 2
    service_requests.first.id.should == 638344
  end
end

describe Open311, ".get_service_request" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/requests/638344.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      to_return(:body => fixture('service_requests.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.get_service_request('638344', :lat => '38.888486', :long => '-77.020179')
    a_request(:get, 'http://blasius.ws:3003/open311/requests/638344.xml').
      with(:query => {:jurisdiction_id => 'dc.gov', :lat => '38.888486', :long => '-77.020179'}).
      should have_been_made
  end

  it "should return the correct results" do
    service_request = Open311.get_service_request(638344, :lat => '38.888486', :long => '-77.020179')
    service_request.id.should == 638344
  end
end

describe Open311, ".post_service_request" do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
      config.api_key      = 'xyz'
    end

    @service_request_params = {
      :service_code   => '001',
      :address_string => '1234 5th street',
      :email          => 'smit222@sfgov.edu',
      :device_id      => 'tt222111',
      :account_id     => '123456',
      :first_name     => 'john',
      :last_name      => 'smith',
      :phone          => '111111111',
      :description    => 'A large sinkhole is destroying the street',
      :media_url      => 'http://farm3.static.flickr.com/2002/2212426634_5ed477a060.jpg',
      :lat            => '38.888486',
      :long           => '-77.020179',
    }
    stub_request(:post, 'blasius.ws:3003/open311/requests.xml').
      with(:body => {:jurisdiction_id => 'dc.gov', :api_key => 'xyz'}.merge(@service_request_params)).
      to_return(:body => fixture('post_service_request.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should return the correct results" do
    service_request_response = Open311.post_service_request(@service_request_params)
    service_request_response.service_request_id.should == '293944'
  end
end

describe Open311, ".request_id" do

  before do
    Open311.configure do |config|
      config.endpoint     = 'http://open311.sfgov.org/dev/v2/'
      config.jurisdiction = 'sfgov.org'
    end
    stub_request(:get, 'http://open311.sfgov.org/dev/v2/tokens/12345.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
      to_return(:body => fixture('request_id_from_token.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it "should request the correct resource" do
    Open311.request_id(12345)
    a_request(:get, 'http://open311.sfgov.org/dev/v2/tokens/12345.xml').
      with(:query => {:jurisdiction_id => 'sfgov.org'}).
      should have_been_made
  end

  it "should return the correct result" do
    service_request = Open311.request_id(12345)
    service_request.id.should == 638344
    service_request.token.should == 12345
  end

end
