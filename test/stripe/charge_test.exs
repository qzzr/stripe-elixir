defmodule Stripe.ChargeTest do
  use ExUnit.Case

  test "A valid charge is successful with card as source" do

    params = [
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 10,
        exp_year: 2020,
        country: "US",
        name: "Ducky Test",
        cvc: 123
      ],
      description: "1000 Widgets",
      capture: false
    ]
    case Stripe.Charges.create(1000,params) do
      {:ok, res} -> assert res.id
      {:error, err} -> flunk err
    end
  end

  test "Listing returns charges" do
    case Stripe.Charges.list() do
      {:ok, charges} -> assert length(charges) > 0
      {:error, err} -> flunk err
    end
  end

  test "Getting a charge" do
    {:ok,[first | _]} = Stripe.Charges.list()
    case Stripe.Charges.get(first.id) do
      {:ok, charge} -> assert charge.id == first.id
      {:error, err} -> flunk err
    end
  end

  test "Capturing a charge" do
    {:ok,[first | _]} = Stripe.Charges.list()
    case Stripe.Charges.capture(first.id) do
      {:ok, charge} -> assert charge.id == first.id
      {:error, err} -> flunk err
    end
  end
  
  test "Changing a charge" do
    {:ok,[first | _]} = Stripe.Charges.list()
    params = [description: "Changed charge"]
    case Stripe.Charges.change(first.id, params) do
      {:ok, charge} -> assert charge.description == "Changed charge"
      {:error, err} -> flunk err
    end
  end
end
