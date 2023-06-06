class ApplicationController < ActionController::API
  def authenticate
    auth_token = token
    if auth_token
      begin
        decoded_token = JWT.decode(auth_token, secret)
        payload = decoded_token.first
        user_id = payload["user_id"]
        @user = User.find(user_id)
      rescue => e
        render json: { message: "Error: #{e}" }, status: :forbidden
      end
    else
      render json: { message: "No Authorization header" }, status: :forbidden
    end
  end

  def token
    auth_header = request.headers['Authorization']

    if auth_header
      auth_header.split(' ')[1]
    else
      auth_header
    end
  end

  def secret
    ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def create_token(payload)
    JWT.encode(payload, secret)
  end
end
