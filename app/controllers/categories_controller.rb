class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    if @categories
      render json: @categories, status: 201
    else
      render json: {error:'There is no categories to be displayed'  }
    end  
  end

  def show
    @category = Category.find_by_id(params[:id])
    if @category
      render json: @category, status: 201
    else
      render json: {error:'There is no categories to be displayed'  }
    end  
  end

  def create
    @category = Category.create(name:params[:name])
    if @category
      render json: @category, status: 201
    else
      render json: {error:'Category could not be created'  }
    end 
  end

  def destroy
     @category = Category.destroy(params[:id])
    if @category
      render json: @category, status: 201
    else
      render json: {error:'This category could not be deleted'  }
    end  
  end

  def update
  end

  private

  def categories_params
     params.permit(:id,:name)
  end
end
