# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Hello', type: :request do
  describe 'GET /v1/hello' do
    it 'returns hello message' do
      get '/v1/hello'
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({ 'message' => 'hello' })
    end

    it 'does not require authentication' do
      get '/v1/hello'
      expect(response).to have_http_status(:ok)
      expect(response).not_to have_http_status(:unauthorized)
    end
  end
end
