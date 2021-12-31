class PaymentController < ApplicationController
   #skip_before_action :verify_authenticity_token, only: [:webhook]
    #before_action :my_cart, only: [:show]
  #before_action :verify_authenticity_token, only: [:show, :update]  


  def order
  #check for customer
    @customer = Customer.find_by_email(params[:email])
    if !@customer
      @customer = Customer.create(customer_params)
    end
    @staff = User.last
    status = Status.first
    if params[:table_number]
      table = Table.find_by_reference(params[:table_number])
      isTakeAway = false
      delivery_time = nil
    else 
      table = Table.first
      isTakeAway = true
      delivery_time = params[:pickupTime]
    end  
    payment = Payment.create()
    #creating empty order
    @order = Order.create(customer_id:@customer.id,user_id:@staff.id, status_id:status.id,table_id:table.id,payment_id:payment.id,isTakeAway:isTakeAway,delivery_time:delivery_time)
     @basket = params[:basket]
     #adding order items to order  
     @total_amount = 0
     @total_quantity = 0
     @basket.each do |item|
     @total_amount += item[:quantity]*item[:price]
     @total_quantity += item[:quantity]
       @order.order_items.create(product_id:item[:id], price:item[:quantity]*item[:price], quantity:item[:quantity])     
     end
     #save total amount to order
     @order.total_amount = @total_amount
     @order.save

     #Gathering data to Create Stripe Session 
    @order_items = OrderItem.where(order_id:@order.id)
    names = @order_items.map do |a|
    a.product.title
    end 
    names = names.uniq().split(",").join(",")    
    descriptions = @order_items.map do |a|
    a.product.description
    end 
    descriptions = descriptions.uniq().split(",").join(",")
    if Rails.env.production?
       @sushme_url = 'https://sushme.netlify.app'
    else
       @sushme_url = 'http://localhost:3001'
   end   
    # Creating stripe session    
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @customer.email,
      line_items: [{
        name: names,
        description: descriptions,
        images: ["https://media.istockphoto.com/photos/healthy-fresh-sushi-roll-set-with-ginger-close-up-japanese-food-picture-id1286622470?b=1&k=20&m=1286622470&s=170667a&w=0&h=B-GBnuB3Whj7r0QdCz5JBqzs180-QBOvFIkIn6mhYUk="],
        amount: (@total_amount*100).to_i,
        currency: "aud",
        quantity:1,
      }],
      payment_intent_data: {
        metadata: {
          order_id: @order.id,
          customer_id: @customer.id,
          user_id:@staff.id
        }
      },
      #success_url: "http://localhost:3001/receipt/#{@order.id}",
      #success_url: "https://sushme.netlify.app/receipt/#{@order.id}",
      success_url: "#{@sushme_url}/receipt/#{@order.id}",

      cancel_url: "https://sushme.netlify.app/payment-failed/#{@order.id}"
    )
    render json:{session:session.id} 
    
  end
  
  # Fetch @cart and send to HTML - payment_success GET  /payment/success
  def success 
   p '------------ success'
  end

  def receipt 
    receipt = Order.find_by_id(params[:id])
    if receipt
      receipt_json = receipt.as_json
      receipt_json[:table] = receipt.table.reference.as_json
      receipt_json[:payment] = receipt.payment.receipt_url.as_json
      receipt_json[:customer] = receipt.customer.as_json

      #receipt_json[:receipt_url] = @receipt.payment.receipt_url.as_json
      #receipt_json[:email] = receipt.customer.email.as_json
      #receipt_json[:username] = receipt.customer.username.as_json
      render json: receipt_json, status: 201
    end
  end

  def failed 
   p '------------ failed'
  end
  
  #From Stripe call back
  def webhook   
    #Receive call back from Stripe API with payment intent; 
    payment_id = params[:data][:object][:payment_intent]    
    p '------------------------------- w pay id'
    p payment_id
    # Retrieve payment information from Stripe API;
    payment = Stripe::PaymentIntent.retrieve(payment_id)    
    @authorization = payment.charges.data[0].outcome.type

    # If payment succeed, update product, update cart, send email with receipt to User, redirect to success page.
    if @authorization && @authorization == "authorized" 
      @receipt = payment.charges.data[0].receipt_url
      order_id = payment.metadata.order_id
      user_id = payment.metadata.user_id
      customer_id = payment.metadata.customer_id
      customer = Customer.find(customer_id)
      order = Order.find(order_id)       
      update_sold(order)
      order.payment.update(receipt_url:@receipt,payment_intent_id:payment_id)
      status = Status.last
      order.update(status:status) 
      UserNotifierMailer.receipt_email(customer, @receipt, order).deliver
      p '------------------------------- w Success'
      render json:{success: "Success"}
    else
    #If payment failed, redirect user
    p '------------------------------- w failed'
     render json:{ notice: "Your Payment has been #{@authorization}, please try again later"}
    end     
  end

  # Helper 
  def update_sold(order)    
    #Update product Sold and available
    order.order_items.each do |item|
    product = Product.find(item.product_id)
    available = product.quantity - item.quantity
    updated = product.update(quantity:available)
    end    
  end

  private

  # Only allow permited paramms 
  def customer_params
    params.permit(:username,:email,:phone) 
  end 

end
