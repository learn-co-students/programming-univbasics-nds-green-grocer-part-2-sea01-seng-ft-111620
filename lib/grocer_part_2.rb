require 'pry'
require_relative './part_1_solution.rb'

=begin

cart = 	[
	{"AVOCADO" => {:price => 3.00, :clearance => true}},
	{"KALE" => {:price => 3.00, :clearance => false}},
	{"AVOCADO" => {:price => 3.00, :clearance => true}},
	{"AVOCADO" => {:price => 3.00, :clearance => true}},
	{"BEETS" => {:price => 2.50, :clearance => false}}
]
	
coupons = [
	{:item => "AVOCADO", :num => 2, :cost => 5.00},
	{:item => "BEER", :num => 2, :cost => 20.00},
	{:item => "CHEESE", :num => 3, :cost => 15.00}
]

=end

# REMEMBER: This method **should** update cart

def apply_coupons(cart, coupons)

index = 0
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    coupon_applies = item_with_coupon != nil && item_with_coupon[:count] >= coupon[:num]
    if item_with_coupon != nil and coupon_applies
      cart << { item: "#{item_with_coupon[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: item_with_coupon[:clearance],
                count: coupon[:num]
              }
      item_with_coupon[:count] -= coupon[:num]
    end
    index += 1
  end
  cart
end


# REMEMBER: This method **should** update cart
# Returns: a new Array where every unique item in the original is present but with its price reduced by 20% if its :clearance value is true

def apply_clearance(cart)
  cart.map do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
    item
  end
end


# This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  # If, after the coupons and discounts are applied, the cart's total is over $100, the customer gets an additional 10% off
  # BEFORE it begins the work of calculating the total (or else you might have some irritated customers)
  # Returns: Float: a total of the cart
  
  
def checkout(cart, coupons)
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total_sum = 0

  final_cart.each do |item|
    total_sum += item[:price] * item[:count]
  end
  
  if total_sum > 100
    total_sum *= 0.9
  else total_sum.round(2)
  end
  
  total_sum
end