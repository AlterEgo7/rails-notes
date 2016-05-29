# Set the header name for username and token retrieval

Rails.configuration.authentication_headers = {
    username: 'X-User-Name',
    auth_token: 'X-Auth-Token'
}