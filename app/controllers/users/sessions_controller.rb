# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :jwt_authenticate_user!, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      render json: { user: resource, token: request.env['warden-jwt_auth.token'] }, status: :ok
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
