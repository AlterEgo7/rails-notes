module UserCredentialsHelper
  def user_credentials_from_header
    username = request.headers.dig(Rails.application.config, :authentication_headers, :username)
    auth_token = request.headers.dig(Rails.application.config, :authentication_headers, :auth_token)
    { username: username, auth_token: auth_token }
  end
end
