defmodule Stripe.CustomerTest do
  use ExUnit.Case

  test "Customers are listed" do
    {:ok, customers} = Stripe.Customers.list
    assert length(customers) > 1
  end

  test "Finding a customer by email works" do
    {:ok, customer} = Stripe.Customers.get "cus_69a4mtRALAYByG"
    assert customer.email == "test@test.com"
  end


end
