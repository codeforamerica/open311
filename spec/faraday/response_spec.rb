require 'helper'

describe Faraday::Response do
  {
    400 => Open311::BadRequest,
    401 => Open311::Unauthorized,
    403 => Open311::Forbidden,
    404 => Open311::NotFound,
    406 => Open311::NotAcceptable,
    500 => Open311::InternalServerError,
    502 => Open311::BadGateway,
    503 => Open311::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        Open311.configure do |config|
          config.endpoint     = 'http://api.dc.org/open311/v2_dev/'
          config.jurisdiction = 'dc.gov'
        end
        stub_request(:get, 'http://api.dc.org/open311/v2_dev/services.xml').
          with(query: {jurisdiction_id: 'dc.gov'}).
          to_return(status: status)
      end

      it "should raise #{exception.name} error" do
        expect do
          Open311.service_list
        end.to raise_error(exception)
      end
    end
  end
end
