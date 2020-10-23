require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  i=0
  new_array = []
  while i < cart.length
    x = 0
    orig_count = cart[i][:count]
    while x < coupons.length
      if cart[i][:item] == coupons[x][:item] && cart[i][:count]>=coupons[x][:num]
        extra = cart[i][:count] - coupons[x][:num]
        if extra > 0
          cart[i][:count] = extra
          new_array << cart[i]
        else
          cart[i][:count] = 0
          new_array << cart[i]
        end  
        item_w_coupon = {item: "#{coupons[x][:item]} W/COUPON", price: coupons[x][:cost]/coupons[x][:num], clearance: cart[i][:clearance], count: coupons[x][:num]} 
        new_array << item_w_coupon
      end  
      x += 1 
    end
    if orig_count == cart[i][:count] #if no coupons applied
      new_array << cart[i]
    end
    i += 1
  end
  new_array
end

def apply_clearance(cart)
  clearance_array = []
  i = 0
  while i < cart.length
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[i][:price]*0.8).round(2)
      clearance_array << cart[i]
    else
      clearance_array << cart[i]
    end
    i += 1 
  end
 clearance_array
end

def checkout(cart, coupons)
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  final_cart = apply_clearance(coup_cart)
  
  i = 0
  subtotal = 0
  
  while i < final_cart.length 
    num = final_cart[i][:price]*final_cart[i][:count]
    subtotal += num
    i += 1
  end
  if subtotal > 100
    total = (subtotal*0.9).round(2)
  else
    total = subtotal.round(2)
  end
  total
end
