module RequestHelper
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_header(version = 1)
      request.headers['Accept'] = "application/my_note.v#{version}"
    end

    def api_response_format(format = Mime::JSON)
      request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def api_authentication_headers(username, token)
      request.headers[Rails.configuration.authentication_headers[:username]] = username
      request.headers[Rails.configuration.authentication_headers[:auth_token]] = token
    end
  end
end