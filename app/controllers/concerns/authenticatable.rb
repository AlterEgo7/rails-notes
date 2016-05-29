module Authenticatable
  def current_user
    @current_user ||= secure_identify_user
  end

  private

  def secure_identify_user
    user = User.find_by(:username, user_credentials_from_header[:username])
    user if Devise.secure_compare(user_credentials_from_header[:auth_token], user.auth_token)
  end
end