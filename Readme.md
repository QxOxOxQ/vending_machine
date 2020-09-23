# Vendor Machine 🍻
## Setup
### Create db
`rake db:create`
`rake db:environment:set`
`rake db:migrate` \
 I recommend enjoy yourself by adding products and money but at the end you can make seed
`ruby db/seed.rb`
### install gems
 install bundler
`gem install bundler`
 install gems
 `bundle`
 
### tests
`rspec`
 
## How it works?
 Every price is in p because it is easy and avoids from mistakes
 
### Product
#### add
 name, price, amount
`rake add_product'[cytryna,135, 2]'`
#### update
`rake update_product"[cola,544,12]"`
#### list
`rake product_list`
### Money
worth, amount
#### add
`rake add_money'[20, 2]'`
#### update
`rake update_money'[20, 2]'`
#### list
`rake money_list`

## Buy
product_name, money( like in true machine each coin separately) \
`rake buy"[cola,1 2 200 200 200]"`

## TIME: 4 h