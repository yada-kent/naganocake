class Public::OrdersController < ApplicationController

    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
    end

    def create
      @order = Order.new(order_params)
      @order.customer = current_customer
      if @order.save

        # 今ログインしているユーザのカートを取得
        cart_items = current_customer.cart_items

        # cart_itemsのそれぞれをOrderDetailにコピ－する(each文を使う)
        cart_items.each do |cart_item|
          @order_details = OrderDetail.new
          @order_details.order_id = @order.id
          @order_details.item_id = cart_item.item.id
          @order_details.amount = cart_item.amount
          @order_details.purchase_price = cart_item.item.price
          @order_details.save
        end
        # カート内の商品を削除する
        cart_items.destroy_all

        redirect_to orders_complete_path
      else
        render :new
      end
    end

    def complete

    end

    def new
        @order = Order.new
        @order.address = current_customer.address
        @order.postal_code = current_customer.postal_code
        last_name = current_customer.last_name
        first_name = current_customer.first_name
        @order.name = "#{last_name} #{first_name}"
    end

    def confirm
        @order = Order.new(order_params)
        @cart_items = current_customer.cart_items
    end

     private
    def order_params
        params.require(:order).permit(:postal_code, :address, :payment_method, :name, :total_amount, :shipping_payment)
    end

end
