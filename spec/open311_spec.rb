require 'helper'

describe Open311 do
  after do
    Open311.reset
  end

  describe '.respond_to?' do
    it 'should return true if method exists' do
      expect(Open311.respond_to?(:new, true)).to be true
    end
  end

  describe '.new' do
    it 'should be a Open311::Client' do
      expect(Open311.new).to be_a Open311::Client
    end
  end
end

describe Open311, '.service_list' do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://api.dc.org/open311/v2_dev/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(query: {jurisdiction_id: 'dc.gov'}).
      to_return(body: fixture('services.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource' do
    Open311.service_list
    expect(a_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
      with(query: {jurisdiction_id: 'dc.gov'})).
      to have_been_made
  end

  it 'should return the correct results' do
    services = Open311.service_list
    expect(services).to be_an Array
    expect(services.first.service_code).to eq('001')
  end
end

describe Open311, '.service_definition' do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(query: {jurisdiction_id: 'dc.gov'}).
      to_return(body: fixture('service_definition.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource' do
    Open311.service_definition('033')
    expect(a_request(:get, 'http://blasius.ws:3003/open311/services/033.xml').
      with(query: {jurisdiction_id: 'dc.gov'})).
      to have_been_made
  end

  it 'should return the correct results' do
    service_def = Open311.service_definition('033')
    expect(service_def).to be_an Hash
    expect(service_def.service_code).to eq('DMV66')
  end
end

describe Open311, '.service_requests' do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/requests.xml').
      with(query: {jurisdiction_id: 'dc.gov'}).
      to_return(body: fixture('service_requests.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource' do
    Open311.service_requests
    expect(a_request(:get, 'http://blasius.ws:3003/open311/requests.xml').
      with(query: {jurisdiction_id: 'dc.gov'})).
      to have_been_made
  end

  it 'should return the correct results' do
    services = Open311.service_requests
    expect(services).to be_an Array
    expect(services.size).to eq(2)
    expect(services.first.service_request_id).to eq('638344')
  end

  describe 'with no results' do
    before do
      stub_request(:get, 'http://blasius.ws:3003/open311/requests.xml').
        with(query: {jurisdiction_id: 'dc.gov'}).
        to_return(body: fixture('service_requests_empty.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
    end

    it 'returns an empty array' do
      services = Open311.service_requests
      expect(services).to eq []
    end
  end
end

describe Open311, '.get_service_request' do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
    end
    stub_request(:get, 'http://blasius.ws:3003/open311/requests/638344.xml').
      with(query: {jurisdiction_id: 'dc.gov'}).
      to_return(body: fixture('get_service_request.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource' do
    Open311.get_service_request(638_344)
    expect(a_request(:get, 'http://blasius.ws:3003/open311/requests/638344.xml').
      with(query: {jurisdiction_id: 'dc.gov'})).
      to have_been_made
  end

  it 'should return the correct results' do
    service_request = Open311.get_service_request(638_344)
    expect(service_request).to be_a Hashie::Mash
    expect(service_request.service_request_id).to eq '638344'
  end

  describe 'when service_request_id is not valid' do
    before do
      stub_request(:get, 'http://blasius.ws:3003/open311/requests/not-an-id.xml').
        with(query: {jurisdiction_id: 'dc.gov'}).
        to_return(body: fixture('get_service_request_not_found.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'}, status: 404)
    end

    it 'raises Open311::NotFound' do
      expect { Open311.get_service_request('not-an-id') }.to raise_error Open311::NotFound
    end
  end
end

describe Open311, '.post_service_request' do
  before do
    Open311.configure do |config|
      config.endpoint     = 'http://blasius.ws:3003/open311/'
      config.jurisdiction = 'dc.gov'
      config.api_key      = 'xyz'
    end

    stub_request(:post, 'blasius.ws:3003/open311/requests.xml').
      to_return(body: fixture('post_service_request.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should return the correct results' do
    service_request_params = {
      service_code: '001',
      address_string: '1234 5th street',
      email: 'smit222@sfgov.edu',
      device_id: 'tt222111',
      account_id: '12345',
      first_name: 'john',
      last_name: 'smith',
      phone: '111111111',
      description: 'A large sinkhole is destroying the street',
      media_url: 'http://farm5.static.flickr.com/4057/4660699337_9aa4541ce1_o.jpg',
      lat: '38.888486',
      long: '-77.020179',
    }
    service_request_response = Open311.post_service_request(service_request_params)
    expect(service_request_response.service_request_id).to eq('293944')
  end
end

describe Open311, '.request_id_from_token' do

  before do
    Open311.configure do |config|
      config.endpoint     = 'http://open311.sfgov.org/dev/v2/'
      config.jurisdiction = 'sfgov.org'
    end
    stub_request(:get, 'http://open311.sfgov.org/dev/v2/tokens/12345.xml').
      with(query: {jurisdiction_id: 'sfgov.org'}).
      to_return(body: fixture('request_id_from_token.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource' do
    Open311.request_id_from_token(12_345)
    expect(a_request(:get, 'http://open311.sfgov.org/dev/v2/tokens/12345.xml').
      with(query: {jurisdiction_id: 'sfgov.org'})).
      to have_been_made
  end

  it 'should return the correct result' do
    service_request = Open311.request_id_from_token(12_345)
    expect(service_request.service_request_id).to eq('638344')
    expect(service_request.token).to eq('12345')
  end

end

describe Open311, 'jurisdiction is an optional request parameter' do
  before do
    Open311.reset
    Open311.configure do |config|
      config.endpoint = 'http://311api.cityofchicago.org/open311/v2/'
    end

    stub_request(:get, 'http://311api.cityofchicago.org/open311/v2/requests/638344.xml').
      to_return(body: fixture('service_requests.xml'), headers: {'Content-Type' => 'text/xml; charset=utf-8'})
  end

  it 'should request the correct resource without a jurisdiction parameter' do
    Open311.get_service_request(638_344)
    expect(a_request(:get, 'http://311api.cityofchicago.org/open311/v2/requests/638344.xml')).
      to have_been_made
  end
end
