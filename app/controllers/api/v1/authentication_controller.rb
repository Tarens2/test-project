class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:login], raise: false

  def login
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        payload = { user_id: @user.id }
        token = create_token(payload)

        render json: { token: token, user: @user }, status: :ok
      else
        render json: { message: 'Authentication failed' }, status: :unauthorized
      end
    else
      render json: { message: 'User is not found' }, status: :unauthorized
    end
  end
end
