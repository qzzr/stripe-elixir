defmodule Stripe.SubscriptionTest do
  use ExUnit.Case

  setup do
    {:ok, [customer | _]} = Stripe.Customers.list(1)
    case Stripe.Customers.create_subscription customer.id, plan: "mav-pilot" do
      {:ok, sub} -> {:ok, [res: sub, customer: customer]}
      {:error, err} -> flunk err
    end

  end

  test "A sub is created", %{res: sub, customer: customer} do
    assert sub.id
  end

  test "Retrieving the sub works", %{res: sub, customer: customer} do
    case Stripe.Customers.get_subcription customer.id, sub.id do
      {:ok, found} -> assert found.id
      {:error, err} -> flunk err
    end
  end

  test "Sub cancellation works", %{res: sub, customer: customer} do
    case Stripe.Customers.cancel_subscription customer.id, sub.id do
      {:ok, canceled_sub} -> assert canceled_sub.id
      {:error, err} -> flunk err
    end
  end

end
