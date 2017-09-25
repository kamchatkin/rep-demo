# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


(1..100).each { |i|
  Product.create(name: 'Product ' + i.to_s, description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
}

shops = [
    ['Киевская',        55.74388,   37.56673  ],
    ['Баррикадная',     55.76027,   37.58111  ],
    ['Белорусская',     55.77492,   37.58207  ],
    ['Новослободская',  55.77921,   37.6009   ],
    ['Проспект мира',   55.781196,  37.633529 ],
    ['Комсомольская',   55.77717,   37.655689 ],
    ['Курская',         55.75848,   37.65985  ],
    ['Таганская',       55.74255,   37.65389  ],
    ['Павелецкая',      55.7313,    37.63612  ],
    ['Добрынинская',    55.72886,   37.62356  ],
    ['Октябрьская',     55.729,     37.61139  ],
    ['Парк культуры',   55.73512,   37.59328  ]
]

shops.each { |shop|
  puts shop[0]
  puts shop[1]
  puts shop[2]
  # Shop.create( name: shop[0], latitude: shop[1], longitude: shop[2], location: ST_GeomFromText('POINT(' + shop[1] + ' '+ shop[2] +')', 4326) )
  # Shop.

  sql = "insert into shops (created_at, updated_at, name, latitude, longitude, location) VALUES ('NOW()', 'NOW()', '"+shop[0].to_s+"', "+shop[1].to_s+", "+shop[2].to_s+", ST_GeomFromText('POINT("+shop[1].to_s+" "+shop[2].to_s+")', 4326) );"
  puts sql
  ActiveRecord::Base.connection.execute(sql)
  # st.execute()
  # st.close

  puts '-'*100
}

(1..shops.length).each { |i|

  (1..10).each { |q|
    rnd = Random.new
    product_id    = rnd.rand(1..100)
    shop_id       = rnd.rand(1..shops.length)
    price         = rnd.rand(100..999)
    quantity      = rnd.rand(0..15)

    ProductsShop.create( product_id: product_id, shop_id: shop_id, price: price, quantity: quantity )
  }

}

