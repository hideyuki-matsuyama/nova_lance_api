# frozen_string_literal: true

RSpec.shared_context 'with sign in', type: :request do
  let(:user) { create(:user) }
  let(:jwt_token) do
    post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    JSON.parse(response.body)['token']
  end
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{jwt_token}"
    }
  end
end
