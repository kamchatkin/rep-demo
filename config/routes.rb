Rails.application.routes.draw do

  root 'welcome#index'

  get 'detect', to: 'welcome#detect', as: 'detect_shop'

  get 'product/:product_id', to: 'welcome#product', as: 'product'

  get 'api/current_shop', to: 'api#current_shop'
  get 'api/use_shop', to: 'api#use_shop'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
