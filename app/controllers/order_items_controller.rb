class OrderItemsController < ApplicationController
  
  def show
    @Order_item = get_cart_item(params[:id])
    @product = @Order_item.product
  end

  # Send Cart item to Edit page - cart_item_edit GET    /cart_item/edit/:id
  def edit
   @cart_item = get_cart_item(params[:id])
   @product = @cart_item.product
  end

  def delete
    del = OrderItem.destroy_by(id:params[:id])
    #redirect_to cart_path(del[0].order_id), notice: "Updated"
  end

  def update
     #getting data
    quantity = params[:quantity].to_i
    @order_item = get_cart_item(params[:id])
    @product = @order_item.product

    #validate purchase, quantity cannot exceed the available quantity 
    if quantity > @product.quantity_available
      redirect_to cart_path(@cart_item.cart_id), alert: "Not Updated!!! Quantity not available, please try less"
    else
    #Update cart item
      price = quantity * @product.price
      updated_item = @cart_item.update(quantity:quantity, price:price)   
      redirect_to cart_path(@cart_item.cart_id), notice: "Updated"
    end
  end

  # Query get cart item
  def get_cart_item(id)
    return CartItem.find(id)    
  end
end
