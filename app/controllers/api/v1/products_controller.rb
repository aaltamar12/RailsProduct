module Api
    module V1
      class ProductsController < ApplicationController
        before_action :authorize_request, except: [:index]
        before_action :set_product, only: [:show, :update, :destroy]

        def index
          @products = Product.all
          render json: @products
        end
  
        def show
          render json: @product
        end
  
        def create
          @product = Product.new(product_params)
          if @product.save
            render json: @product, status: :created
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        end
  
        def update
          if @product.update(product_params)
            render json: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        end
  
        def destroy
          @product.destroy
          head :no_content
        end
  
        private


      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = JsonWebToken.decode(header)
        @current_user = User.find_by(id: decoded[:user_id]) if decoded
        render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
      end
  
        def set_product
          @product = Product.find(params[:id])
        end
  
        def product_params
          params.require(:product).permit(:name, :description, :price, images: [])
        end
      end
    end
  end
  