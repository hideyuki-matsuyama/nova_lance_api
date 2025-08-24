# frozen_string_literal: true

module V1
  class HelloController < ApplicationController
    skip_before_action :jwt_authenticate_user!, only: [:index]

    def index
      render json: { message: 'hello' }, status: :ok
    end
  end
end
