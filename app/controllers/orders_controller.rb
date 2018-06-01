class OrdersController < ApplicationController
  skip_after_action :verify_authorized

  def create
    category = Category.find(params[:category_id])
    order  = Order.create!(category_name: category.name, amount_cents: category.price_cents, state: 'pending', user: current_user)

    redirect_to new_order_payment_path(order)
  end

  def show
  @order = current_user.orders.where(state: 'paid').find(params[:id])
  end
end