defmodule Seminar.Monad.RawCalculatorTest do
  use ExUnit.Case
  use Witchcraft

  alias Seminar.Adt.Expr.{Val, Div}
  alias Seminar.Monad.RawCalculator, as: Calc

  test "success cases" do
    assert Val.new(2) |> Calc.eval() == 2

    assert Div.new(
             Val.new(4),
             Val.new(2)
           )
           |> Calc.eval() == 2

    assert Div.new(
             Val.new(10),
             Div.new(Val.new(4), Val.new(2))
           )
           |> Calc.eval() == 5
  end

  test "failure cases" do
    assert_raise ArithmeticError, fn ->
      Div.new(
        Val.new(10),
        Val.new(0)
      )
      |> Calc.eval()
    end
  end
end
