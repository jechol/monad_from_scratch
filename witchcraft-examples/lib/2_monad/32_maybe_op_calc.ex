defmodule Example.MaybeOpCalc do
  use Witchcraft

  alias Example.Expr.{Val, Div}
  alias Algae.Maybe.{Just, Nothing}

  def eval(%Val{val: val}), do: Just.new(val)

  def eval(%Div{num: num, denom: denom}) do
    eval(num) >>>
      fn num_val ->
        eval(denom) >>>
          fn denom_val ->
            safe_div(num_val, denom_val)
          end
      end
  end

  defp safe_div(_, 0), do: Nothing.new()
  defp safe_div(n, m), do: Just.new(n / m)
end
