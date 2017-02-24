defmodule SalesTax do
  def calc(orders) do
    tax_rates =
      [ NC: 0.075, TX: 0.08 ]

    for order <- orders do
      tax_rate = tax_rates[order[:ship_to]]
      if(tax_rate != nil) do
        order ++ [total_amount: order[:net_amount] + (order[:net_amount]*tax_rate)]
      else
        order ++ [total_amount: order[:net_amount]]
      end
    end
  end
end

