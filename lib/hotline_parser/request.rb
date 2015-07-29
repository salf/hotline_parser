require 'typhoeus'

class Request
  def initialize(url)
    @request = Typhoeus::Request.new(url, method: :get)
  end

  def make_request
    response = @request.run
    if response.success?
      response.body
    else
      nil
    end
  end

end