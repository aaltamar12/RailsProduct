# spec/controllers/api/v1/users_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Test User',
      email: 'testuser@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'Test User',
      email: 'testuser@example.com',
      password: 'password',
      password_confirmation: 'wrongpassword'
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['email']).to eq('testuser@example.com')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['password_confirmation']).to include("doesn't match Password")
      end
    end
  end

  describe 'POST #login' do
    let!(:user) { User.create!(valid_attributes) }

    context 'with valid credentials' do
      it 'returns a token and user name' do
        post :login, params: { email: 'testuser@example.com', password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['token']).not_to be_nil
        expect(JSON.parse(response.body)['name']).to eq('Test User')
      end
    end

    context 'with invalid credentials' do
      it 'renders a JSON response with an unauthorized error' do
        post :login, params: { email: 'testuser@example.com', password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['error']).to eq('unauthorized')
      end
    end
  end
end