# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :jwt_authenticate_user!

  private

  def jwt_authenticate_user!
    Rails.logger.debug { "🔥 #{Rails.env}" }
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

    payload = decode_jwt_token(token)
    return nil unless payload

    find_user_by_payload(payload)
  end

  def decode_jwt_token(token)
    decoded_token(token).first
  rescue JWT::DecodeError => e
    Rails.logger.debug { "JWT decode error: #{e.message}" }
    nil
  rescue JWT::VerificationError => e
    Rails.logger.debug { "JWT verification error: #{e.message}" }
    nil
  end

  def find_user_by_payload(payload)
    user_id = payload['sub']
    jti = payload['jti']

    # JTIMatcherを使用する場合はjtiを確認
    user = User.find_by(id: user_id)
    return nil unless user
    return nil unless user.jti == jti

    user
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.debug { "User not found: #{e.message}" }
    nil
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    return nil unless auth_header&.start_with?('Bearer ')

    auth_header.split.last
  end

  def decoded_token(token)
    JWT.decode(
      token,
      secret_key,
      true,
      { algorithm: 'HS256' }
    )
  end

  def secret_key
    # 環境変数からJWTシークレットキーを取得
    if Rails.env.test?
      ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.credentials.devise_jwt_secret_key
    else
      Rails.application.credentials.devise_jwt_secret_key!
    end
  rescue StandardError => e
    Rails.logger.error("JWT secret key configuration error: #{e.message}")
    raise('JWT secret key is not configured')
  end
end
