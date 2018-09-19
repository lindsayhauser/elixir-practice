defmodule Practice.Factor do

  # Finds all of the prime factors for a given number greater than 1.
  # Referenced https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/
  # for ideas on how to find prime factors
  def factor(x) when x >= 2 and is_integer(x) do
    acc = []
    cond do
      rem(x, 2) == 0 -> Enum.sort(factorHelperEven(x, acc))
      true -> Enum.sort(factorHelperOdd(x, 3, acc))
    end
  end

  defp factorHelperOdd(x, divisor, acc) do
    cond do
      x <= 1 -> acc
      rem(x, divisor) == 0 ->
        factorHelperOdd(div(x, divisor), divisor, [divisor] ++ acc)
      divisor > :math.sqrt(x) -> [x] ++ acc
      true -> factorHelperOdd(x, divisor + 2, acc)
    end
  end

  defp factorHelperEven(x, acc) do
    cond do
      x <= 1 -> acc
      rem(x, 2) == 0 -> factorHelperEven(div(x, 2), [2] ++ acc)
      true -> factorHelperOdd(x, 3, acc)
    end
  end
end
