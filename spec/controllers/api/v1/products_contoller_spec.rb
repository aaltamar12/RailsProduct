require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Product', description: 'Product description', price: 100.0, images: ['image1.png'] }
  }

  let(:invalid_attributes) {
    { name: nil, description: 'Product description', price: 100.0, images: ['image1.png'] }
  }

  let(:product) { Product.create!(valid_attributes) }
  let(:user) { User.create!(email: 'user@example.com', password: 'password', name: 'User') }

  before do
    # Assuming you have a method to set the current user
    allow(controller).to receive(:authorize_request).and_return(user)
    request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Product.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'renders a JSON response with the new product' do
        post :create, params: { product: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new product' do
        post :create, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        { name: 'Updated Product' }
      }

      it 'updates the requested product' do
        put :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.name).to eq('Updated Product')
      end

      it 'renders a JSON response with the product' do
        put :update, params: { id: product.to_param, product: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the product' do
        put :update, params: { id: product.to_param, product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product
      expect {
        delete :destroy, params: { id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it 'returns no content' do
      delete :destroy, params: { id: product.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end
