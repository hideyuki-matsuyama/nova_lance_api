# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Examples', type: :request do
  include_context 'with sign in'

  let(:user) { create(:user) }
  let!(:example) { create(:example, first_name: 'ほげ夫') }

  describe 'GET /v1/examples' do
    it 'returns a list of examples' do
      get '/v1/examples', headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'ほげ夫'
    end
  end

  describe 'GET /v1/examples/:id' do
    it 'returns the example' do
      get "/v1/examples/#{example.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'ほげ夫'
    end
  end

  describe 'POST /v1/examples' do
    it 'creates a new example' do
      expect do
        post '/v1/examples', params: { first_name: '花子', last_name: '佐藤' }.to_json, headers: headers
      end.to change(Example, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(response.body).to include('花子')
    end
  end

  describe 'PATCH /v1/examples/:id' do
    it 'updates the example' do
      patch "/v1/examples/#{example.id}", params: { first_name: '次郎' }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('次郎')
    end
  end

  describe 'DELETE /v1/examples/:id' do
    it 'deletes the example' do
      expect do
        delete "/v1/examples/#{example.id}", headers: headers
      end.to change(Example, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
