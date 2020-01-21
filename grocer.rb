def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do 
    if collection[i][:item] == name
      return collection[i]
    end
    i+= 1
  end
  nil
end

# Custom function!
def get_cart_index(item_name, cart)
  # Returns the index of the `cart` at which the `item_name` exists (nil if item not in cart)
  i = 0
  while i < cart.length do
    if cart[i][:item] == item_name
      return i
    end
    i += 1
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated = []
  
  i = 0
  while i < cart.length do
    item = cart[i]
    consolidated_index = get_cart_index(item[:item], consolidated)
    
    if consolidated_index.nil?
      item[:count] = 1
      consolidated << item  
    else
      consolidated[consolidated_index][:count] += 1
    end
    
    i += 1
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0
  while i < coupons.length do
    coupon_item = coupons[i][:item]
    coupon_cost = coupons[i][:cost]
    coupon_num = coupons[i][:num]
    
    cart_index = get_cart_index(coupon_item, cart)

    if not cart_index.nil?
      item = cart[cart_index]

      if item[:count] >= coupon_num
        
        # Reduce the item count (overwrite)
        item[:count] -= coupon_num  
        cart[cart_index] = item
      
        # Add coupon'd items to cart
        cart << {
          :item => coupon_item + " W/COUPON", 
          :price =>  coupon_cost/coupon_num, 
          :clearance => item[:clearance],
          :count => coupon_num
        }
      end
    
    end
    
    i += 1
  end
  
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  new_cart = []
  
  i = 0 
  while i < cart.length do 
    item = cart[i]
    
    if item[:clearance]
      item[:price] *= 0.8
    end
    
    new_cart << item
    
    i += 1 
  end
  new_cart
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
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  
  total = 0
  i = 0
  while i < clearanced_cart.length do 
    total += (clearanced_cart[i][:price] * clearanced_cart[i][:count]).round(2)
    i += 1
  end
  
  if total >= 100
    total *= 0.9
  end
  
  total
end
