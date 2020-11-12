require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0 
  while counter < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_item_name = "#{coupons[counter][:item]} W/COUPON" 
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num] 
        cart_item[:count] -= coupons[counter][:num]
      else 
        cart_item_with_coupon = {
          :item => coupon_item_name, 
          :price => coupons[counter][:cost] / coupons[counter][:num], 
          :clearance => cart_item[:clearance], 
          :count => coupons[counter][:num]
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
    if cart[counter][:clearance] === true
      clearance = cart[counter][:price] * 0.8
      cart[counter][:price] = clearance.round(2)
    end 
    counter += 1 
  end 
  cart 
end

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE", :price => 3.00, :clearance => false}
]

coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

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


consol_cart = consolidate_cart(cart) 
coupons_cart = apply_coupons(consol_cart, coupons)
cart_full_discount = apply_clearance(coupons_cart) 

counter = 0
total = 0
while counter < cart_full_discount.length do 
  total += cart_full_discount[counter][:price] * cart_full_discount[counter][:count]
  counter += 1 
end 

if total > 100 
  total = total * 0.9 
end 

return total.round(2)

end



