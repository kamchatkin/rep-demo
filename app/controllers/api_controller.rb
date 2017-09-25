class ApiController < ApplicationController

  # находит блжайший магазин по координатам
  def current_shop

    lat = params[:latitude]
    long = params[:longitude]

    session[:curr_geo] = {
        latitude: lat,
        longitude: long
    }

    sql = "SELECT id,name, ST_Distance(location::geography, 'SRID=4326;POINT("+lat+" "+long+")'::geography)/1000 as dist_km FROM shops ORDER BY dist_km asc limit 1"
    shop = Shop.find_by_sql(sql)

    respond_to do |format|
      msg = { :ok => true, shop: shop[0] }
      format.json  { render :json => msg } # don't do msg.to_json
    end

  end

  # запоминает магазин для сессии
  def use_shop
    shop_id = params[:shop_id]
    session[:shop_id] = shop_id
  end

end
