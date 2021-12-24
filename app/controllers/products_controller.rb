class ProductsController < ApplicationController


  def index
    @products = Product.all.map do |product|
      product_json = product.as_json
      product_json[:picture] = product.picture.url.as_json
      product_json[:category] = product.category.name
      product_json
    end
    if @products
    render json: { products: @products }, status: 201
    else  
      render json:{error: "Products not found"}, status: 404
    end
  end

  def top_seller
    @products = Product.all.map do |product|
      if product.category.name === 'Top Seller'
        product_json = product.as_json
        product_json[:picture] = product.picture.url.as_json
        product_json[:category] = product.category.name
        product_json
      end
    end
    if @products
    render json: { products: @products }, status: 201
    else  
      render json:{error: "Products not found"}, status: 404
    end
  end

  def show
    @product = Product.find_by_id(params[:id])
    if @product
      picture = @product.picture.url
      @product = @product.as_json
      @product[:picture] = picture.as_json
      render json: { product: @product }, status: 201
    else  
      render json:{error: "Product could not be found"}
    end
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    if @product
      @product.destroy
      render json: @product, status: 201
    end  
  end

  def create
    @product = Product.create(product_params)
    @product.save
     if @product
     render json: @product, status: 201
    else  
      render json:{error: "Product could not be created"}
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    @product.title = params[:title]
    @product.description = params[:description]
    @product.status = params[:status]
    @product.category_id = params[:category_id]
    @product.price = params[:price]
    if params[:picture]
      @product.picture = params[:picture]
    end  
    @product.save

    if @product
      render json:{msg:"Product successfuly updated"}, status: 200 
    else 
      render json:{msg:"Something went wrong, please try again later or contact the admin"}
    end   

  end

  private

  def product_params
    params.permit(:title,:description,:status,:category_id, :id, :price, :picture)
  end
end
