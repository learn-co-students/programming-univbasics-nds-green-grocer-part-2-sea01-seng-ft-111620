require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
      if cart_item && cart_item[:count] >= coupons[counter][:num]
        if cart_item_with_coupon
          cart_item_with_coupon[:count] += coupons[counter][:num]
          cart_item[:count] -= coupons[counter][:num]
        else
          cart_item_with_coupon = {
            :item => couponed_item_name,
            :price => coupons[counter][:cost] / coupons[counter][:num],
            :count => coupons[counter][:num],
            :clearance => cart_item[:clearance]
          }
          cart << cart_item_with_coupon
          cart_item[:count] -= coupons[counter][:num]
        end 
      end 
      counter += 1 
  end
  cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length do 
    if cart[counter][:clearance] == true 
     cart[counter][:price] = (cart[counter][:price] * 0.80).round(1)
    end
    counter += 1 
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  cart_with_coupons_clearance = apply_clearance(cart_with_coupons)

  
  counter = 0
  total = 0
  while counter < cart_with_coupons_clearance.length do 
    total += cart_with_coupons_clearance[counter][:price] * cart_with_coupons_clearance[counter][:count]
    counter += 1 
  end
  if total >= 100 
    total * 0.9
  else 
    total
  end 
end
