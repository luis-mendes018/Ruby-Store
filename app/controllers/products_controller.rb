class ProductsController < ApplicationController
 layout "admin", except: %i[catalog catalog_show]

 allow_unauthenticated_access only: %i[catalog catalog_show]

 before_action :set_product, only: %i[show edit update destroy]

def index
 products = Product.includes(:category).order(created_at: :desc)


  if params[:name].present?
    products = products.where(
      "products.name ILIKE ?",
      "%#{params[:name]}%"
    )
  end

 @pagy, @products = pagy(:offset, products)
end

def show
end

def new
 @product = Product.new
 @categories = Category.order(:name)
end

def edit
 @categories = Category.order(:name)
end

def create
 @product = Product.new(product_params)


 if @product.save
   redirect_to products_path, notice: "Produto criado com sucesso."
 else
   @categories = Category.order(:name)
   render :new, status: :unprocessable_entity
 end
end

def update
 if @product.update(product_params)
 redirect_to products_path, notice: "Produto atualizado com sucesso."
 else
   @categories = Category.order(:name)
 render :edit, status: :unprocessable_entity
 end
end

def destroy
 @product.destroy


 redirect_to products_path, notice: "Produto excluído com sucesso."
end

def catalog
  @categories = Category.order(:name)
  @products = Product
     .includes(:category)
     .where(active: true)
     .order(:name)

  if params[:category_id].present?
    @products = @products.where(category_id: params[:category_id])
  end
end

def catalog
  @categories = Category.order(:name)

  products = Product
              .includes(:category)
              .where(active: true)
              .order(:name)

  if params[:name].present?
    products = products.where(
      "products.name ILIKE ?",
      "%#{params[:name]}%"
    )
  end

  if params[:category_id].present?
    products = products.where(category_id: params[:category_id])
  end

  @pagy, @products = pagy(:offset, products, limit: 6)
end

def catalog_show
  @product = Product.includes(:category).find(params[:id])
end

private

def set_product
 @product = Product.find(params[:id])
end

 def product_params
  params.expect(
  product: [
  :name,
  :description,
  :price,
  :stock_quantity,
  :active,
  :category_id,
  :image
  ]
  )
 end
end
