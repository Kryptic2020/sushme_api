class ProductsController < ApplicationController


  def index
    @products = Product.all
    if @products
     render json: @products, status: 201
    else  
      render json:{error: "Products not found"}, status: 404
    end
  end

  def show
     @product = Product.find_by_id(params[:id])
     if @product
     render json: @product, status: 201
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
    @product.save
    if @product
      render json:{msg:"Product successfuly updated"}, status: 200 
    else 
      render json:{msg:"Something went wrong, please try again later or contact the admin"}
    end   

  end

  private

  def product_params
    params.require(:product).permit(:title,:description,:status,:category_id, :id, :price)
  end
end
