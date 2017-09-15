require 'pry'
def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |hash|
    hash.each do |item, details|
      if consolidated_cart.has_key?(item)
        # binding.pry
        consolidated_cart[item][:count] += 1
      else
        consolidated_cart[item] = details
        consolidated_cart[item][:count] = 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && cart[item][:count] >= coupon[:num]
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += 1
      else
        cart["#{item} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, hash|
    if hash[:clearance] == true
      clearance_price = (hash[:price] - (hash[:price] * 0.20)).round(2)
      hash[:price] = clearance_price
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  reduced_cart = apply_clearance(applied_coupons)

  cart_total = 0
  reduced_cart.values.each do |item|
    cart_total += (item[:price] * item[:count])
  end

  if cart_total > 100
    cart_total * 0.90
  else
    cart_total
  end

end
