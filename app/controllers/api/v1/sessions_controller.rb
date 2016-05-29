class Api::V1::SessionsController < ApplicationController

  def create
    user_password = params[:session][:password]
    user_name = params[:session][:username]
    user = user_name.present? && User.find_by(username: user_name)

    if user.valid_password? user_password
      sign_in user, store: false
      user.reset_authentication_token!
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: 'Invalid username or password' }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.reset_authentication_token!
    head 204
  end
end
