require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.map { |produce|
    produce.map { |key, value|
      coupons.map { |tag|
        tag.map { |t_key, t_value|
          if value == t_value && key == t_key
            produce[:count] = produce[:count] - tag[:num]
            cart.push({
              :item => t_value + " W/COUPON",
              :price => tag[:cost] / tag[:num],
              :clearance => produce[:clearance],
              :count => tag[:num]
            })
          end
        }
      }
    }
  }
  return cart
end

def apply_clearance(cart)
  cart.map { |produce|
    produce.map { |key, value|
      if key == :clearance && value == true
        produce[:price] = produce[:price] - ((produce[:price] * 0.2).round(2))
      end
    }
  }
  return cart
end

def checkout(cart, coupons)
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons.uniq))
  cart_total = 0.0
  
  new_cart.map { |produce|
    produce.map { |key, value|
      if key == :price
        cart_total = cart_total + (value * produce[:count])
      end
    }
  }
  if cart_total > 100 
    cart_total = cart_total - ((cart_total * 0.1).round(2))
  end
  return cart_total
end
