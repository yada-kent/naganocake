class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

 def update
  @cart_item = CartItem.find(params[:id])
  @cart_item.update(cart_item_params)
  redirect_to cart_items_path, notice: "カートアイテムを更新しました"
 end


  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "カートアイテムを削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました"
  end

  def create
    #カートアイテムの検索
    @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    #もしカートアイテムがなければ新たに作成する
    if @cart_item.nil?
    @cart_item = current_customer.cart_items.new(cart_item_params)
    else
      #もしカートアイテムがすでにある場合、数量を加算する
      @cart_item.amount += cart_item_params[:amount].to_i
    end
    if @cart_item.save
      redirect_to cart_items_path, notice: "カートに追加しました"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
