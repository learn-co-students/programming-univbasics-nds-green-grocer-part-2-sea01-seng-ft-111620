require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do | grocery_item |
    coupons.each do | coupon_element |
      if grocery_item[:item] == coupon_element[:item]
        
        if coupon_element[:num] <= grocery_item[:count]
          new_item_with_coupon = {:item => "#{grocery_item[:item]} W/COUPON", :price => (coupon_element[:cost] / coupon_element[:num]), 
          :clearance => grocery_item[:clearance],
          :count => coupon_element[:num]}
          
          cart << new_item_with_coupon
          grocery_item[:count] -= coupon_element[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do | cart_element |
    if cart_element[:clearance]
      cart_element[:price] = (cart_element[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  new_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(new_cart, coupons)
  cart_CC = apply_clearance(cart_with_coupons)
  final_total = 0;
  
  cart_CC.each do | cart_element |
    final_total += (cart_element[:price] * cart_element[:count])
  end
  if final_total > 100
    final_total *= 0.9
  end
  final_total
end
