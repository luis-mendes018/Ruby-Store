class CartsController < ApplicationController
  before_action :set_cart
  def show
  end

  def add
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)

    desired_quantity = cart_item.new_record? ? 1 : cart_item.quantity + 1
    if desired_quantity <= product.stock_quantity
      cart_item.quantity = desired_quantity
      cart_item.save!
    end

    redirect_to cart_path
  end

    def increase
     product = Product.find(params[:product_id])
      cart_item = @cart.cart_items.find_by(product: product)
     if cart_item && cart_item.quantity + 1 <= product.stock_quantity
      cart_item.increment!(:quantity)
     end

     redirect_to cart_path
    end

  def decrease
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_by(product: product)
    if cart_item && cart_item.quantity > 1
      cart_item.decrement!(:quantity)
    elsif cart_item
      cart_item.destroy
    end

    redirect_to cart_path
  end

  def remove
     product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_by(product: product)
    cart_item.destroy if cart_item

    redirect_to cart_path
  end

  private

  def set_cart
    @cart = Current.user.cart
    @cart ||= Current.user.create_cart
  end
end
