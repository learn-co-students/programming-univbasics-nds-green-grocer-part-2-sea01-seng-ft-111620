require_relative './part_1_solution.rb'
require 'pry' 


def apply_coupons(cart, coupons)
  cart.each do | item |
    coupons.each do | it_coupon |
      if item[:item] == it_coupon[:item]
        if it_coupon[:num] <= item[:count]
          couponed_item = {:item => "#{item[:item]} W/COUPON", :price => (it_coupon[:cost] / it_coupon[:num]), 
          :clearance => item[:clearance],
          :count => it_coupon[:num]}
          
          cart << couponed_item
          item[:count] -= it_coupon[:num]
        end
      end
    end
  end
  cart
  #binding.pry 
end




def apply_clearance(cart)
  new_cart = [] 
  cart.each do |item|
    if item[:clearance]
      item[:price] *= 0.8.round(2)
      new_cart << item
    else
      new_cart << item 
    end   
  #binding.pry
  end
  new_cart
end

def checkout(cart, coupons)
 new_cart = consolidate_cart(cart)
 coupon_cart = apply_coupons(new_cart, coupons)
 clearance_cart = apply_clearance(coupon_cart)
 total = 0 
 
 clearance_cart.each do |item|
   total += (item[:price] * item[:count])
 end
 if total > 100
   total *= 0.9
 end 
total.round(2) 
end


