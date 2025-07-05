# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :jwt_authenticate_user!

  private

  def jwt_authenticate_user!
    Rails.logger.debug 'JWT authentication check'
    Rails.logger.debug { "Authorization header: #{request.headers['Authorization']}" }

    user = current_user
    Rails.logger.debug { "Current user: #{user.inspect}" }

    head :unauthorized unless user
  end

  def current_user
    @current_user ||= authenticate_user_from_token
  end

  def authenticate_user_from_token
    token = extract_token_from_header
    return nil unless token

    begin
      payload = decoded_token(token).first
      user_id = payload['sub']
      jti = payload['jti']

      User.find_by!(id: user_id, jti: jti)
    end
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    return nil unless auth_header&.start_with?('Bearer ')

    auth_header.split.last
  end

  def decoded_token(token)
    JWT.decode(
      token,
      Rails.application.credentials.devise_jwt_secret_key || ENV['DEVISE_JWT_SECRET_KEY'] || 'test_secret_key',
      true,
      { algorithm: 'HS256' }
    )
  end
end
