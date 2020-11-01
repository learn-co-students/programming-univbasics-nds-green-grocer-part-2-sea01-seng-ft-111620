require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)


  cart.each do |item|
    #look at each item in cart
    coupons.each do |item_2|
      #look at all of our coupons
      if item[:item] == item_2[:item] && item[:count] >= item_2[:num]
        #if an item in our cart matches an item we have a coupon for and minimum amount for
        item[:count] = item[:count] - item_2[:num]
          #Removing the item count; next line replaces the remaining count with a new item with the coupon's discount.
        cart << {:item => "#{item[:item]} W/COUPON", :price => item_2[:cost] / item_2[:num], :clearance => item[:clearance], :count => item_2[:num]}
      end
    end
  end
  cart
end

def apply_clearance(cart)
  #look at each item in the cart
    #if it's on clearance, reduce the price by 20% and round it.
  cart.each do|product|
    if product[:clearance] == true
       product[:price] = product[:price] - (product[:price] * 0.20)
       product[:price].round
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0.0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
    #Applying all of the discounts
  cart.each do |product|
    total += product[:price] * product[:count]
  end
    #Adding up all of our items
  if total > 100
    total = total - (total * 0.1)
  end
    #Applying 10% discount to carts over $100
  total
end
