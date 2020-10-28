require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    currentItem = find_item_by_name_in_collection(coupon[:item], cart)
    if currentItem && currentItem[:count] >= coupon[:num]
        cart << {:item => currentItem[:item] + " W/COUPON", :price => coupon[:cost]/coupon[:num], 
        :clearance => currentItem[:clearance], :count => coupon[:num]
        }
        currentItem[:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each { |item| item[:price] = (item[:price]*0.8).round(2) if item[:clearance] }
end

def checkout(cart, coupons)
  total = apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).inject(0) {|sum,hash| sum + hash[:price]*hash[:count]}
  total < 100 ? total : total*0.9
end
