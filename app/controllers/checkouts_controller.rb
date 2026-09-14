class CheckoutsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def create
    @cart_items = @cart.cart_items.includes(:product)

    if @cart_items.empty?
      redirect_to cart_path, alert: "Seu carrinho está vazio."
      return
    end

    ActiveRecord::Base.transaction do
      order = Order.create!(
        user: Current.user,
        status: "pending",
        name: checkout_params[:name],
        email: checkout_params[:email],
        cep: checkout_params[:cep],
        street: checkout_params[:street],
        number: checkout_params[:number],
        complement: checkout_params[:complement],
        neighborhood: checkout_params[:neighborhood],
        city: checkout_params[:city],
        state: checkout_params[:state],
        total: calculate_total
      )

      @cart_items.each do |cart_item|
        product = cart_item.product
        order.order_items.create!(
          product: product,
          product_name: product.name,
          unit_price: product.price,
          quantity: cart_item.quantity
        )

        product.decrement!(:stock_quantity, cart_item.quantity)
      end

      @cart.cart_items.destroy_all
    end

    redirect_to catalog_path, notice: "Pedido realizado com sucesso!"
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :show, status: :unprocessable_entity
  end

  private

  def set_cart
    @cart = Current.user.cart
    @cart ||= Current.user.create_cart
  end

  def checkout_params
    params.permit(
      :name,
      :email,
      :cep,
      :street,
      :number,
      :complement,
      :neighborhood,
      :city,
      :state
    )
  end

  def calculate_total
    @cart_items.sum do |cart_item|
      cart_item.product.price * cart_item.quantity
    end
  end
end
