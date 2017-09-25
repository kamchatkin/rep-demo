# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  (->
    $detect = $('#detect')
    $detect_res = $('#detect_res')
    $detect_res_button = $detect_res.find('button')
    $choose = $('#choose')

    return if $detect.length is 0 || $choose.length is 0

    founded_shop_id = -1

    on_geo_success = (pos)->
      url = '/api/current_shop'
      params = {
        latitude: pos.coords.latitude,
        longitude: pos.coords.longitude
      }
      on_founded_shop = (data)->
        return if !data.shop
        founded_shop_id = data.shop.id
        $detect.hide()
        $detect_res.find('span').text( data.shop.name )
        $detect_res.show()
        setTimeout(()->
          $choose.show()
        , 2000 )
        $detect_res_button.click ->
          $.get( '/api/use_shop', { shop_id: data.shop.id }, (data) ->
            document.location.href = '/'
          )
        return
      $.get url, params, on_founded_shop
      return

    on_geo_error = (error)->
      $detect.hide()
      $choose.show()
      return

    if !navigator.geolocation
      on_geo_error('')
      return

    navigator.geolocation.getCurrentPosition( on_geo_success, on_geo_error);
    return
  )();

  (->
    return if !navigator.geolocation
    return if document.location.pathname is '/detect'

    watch_id = -1
    q_state = false

    on_geo_success = (pos)->
      return if q_state
      q_state = true
      lat = pos.coords.latitude
      lng = pos.coords.longitude

      curr_lat = current_geo.lat
      curr_lng = current_geo.lng

      return if lat is curr_lat && lng is curr_lng

      msg = 'Была изменена ваша геопозиция. Найти ближайший магазин?'
      if confirm(msg)
        document.location.href = '/detect'
      else
        navigator.geolocation.clearWatch( watch_id )
        q_state = false
      return

    on_geo_error = ->

    position_options = {
      coords: {
        latitude:   current_shop.lat,
        longitude:  current_shop.lng
      }
    }

    watch_id = navigator.geolocation.watchPosition( on_geo_success, on_geo_error, position_options );

  )()

  (->
    $detect_page = $('.detect_page')
    $detect_page.find('#choose a').click (evt)->
      evt.preventDefault()
      $.get( '/api/use_shop', {shop_id: $(this).data('shop-id')}, (data) ->
        document.location.href = '/'
      )
  )()
