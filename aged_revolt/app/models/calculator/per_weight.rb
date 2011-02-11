class Calculator::PerWeight < Calculator
  #preference :amount, :decimal, :default => 0
  preference :first_item,      :decimal, :default => 0
  preference :additional_pound, :decimal, :default => 0

  def self.description
    "Flat Rate Per Weight"
  end

  def self.available?(object)
    true
  end

  def self.register
    super
    Coupon.register_calculator(self)
    ShippingMethod.register_calculator(self)
    ShippingRate.register_calculator(self)
  end

  def compute(object=nil)
    sum = 0
    object.length.times do |i|
      if i < 1
        sum += self.preferred_first_item
      else
        sum += self.preferred_additional_pound * object[i].variant.weight
      end
    end
    return(sum)
  end
  
end
