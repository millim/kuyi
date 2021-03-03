module HomeHelper
  def format_price(org_price)
    org_price / 1.00 / Contract::PRICE_UNIT
  end
end
