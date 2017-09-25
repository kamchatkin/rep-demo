class WelcomeController < ApplicationController

  before_action :require_shop, only: [:index, :product]
  before_action :current_shop

  def index

    @products = @shop.products

    if @products.nil?
      @products = []
    end

  end


  def detect
    @shops = Shop.all
  end

  def product

    product_id = params[:product_id]

    @product = @shop.products.where(id:product_id)
    if @product.length < 1
      redirect_to root_url
    end

    @product = @product[0]

    @shops = @product.shops

    @shops_name = []
    @shops_coords = []

    @shops.each { |shop|
      @shops_name << shop.name
      @shops_coords << {
          name: shop.name,
          lat: shop.latitude,
          long: shop.longitude
      }
    }

  end






  private

  def require_shop
    @shop_id = session[:shop_id]

    if !@shop_id
      redirect_to detect_shop_url
    end
  end

  def current_shop
    shop_id = session[:shop_id]
    if shop_id
      @shop = Shop.find(shop_id)
    end
  end

end
