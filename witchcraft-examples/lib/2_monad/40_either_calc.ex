defmodule Example.EitherCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Either.{Left, Right}

  def eval(%Val{val: val}), do: Right.new(val)

  def eval(%Div{num: num, denom: denom}) do
    monad %Right{} do
      num_val <- eval(num)
      denom_val <- eval(denom)
      safe_div(num_val, denom_val)
    end
  end

  defp safe_div(_, 0), do: Left.new(:div_by_zero)
  defp safe_div(n, m), do: Right.new(n / m)
end
