class Public::OrdersController < ApplicationController

    def index

    end

    def show

    end

    def complete

    end

    def new
        @order = Order.new
        @order.address = current_customer.address
    end

    def confirm
        @order = Order.new(order_params)
        @cart_items = current_customer.cart_items
    end

     private
    def order_params
        params.require(:order).permit(:postal_code, :address, :payment_method, :name)
    end

end
