defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # String expression = String.split(expr, "+")
    # expression = String.split(expression, "-")
    # expression = String.split(expression, "*")
    # expression = String.split(expression, "/")
    expr
    |> String.split(~r/\s+/)
    |> hd
    |> parse_float
    |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  # Is the given string a palindrome
  def isPalindrome(expr) when is_binary(expr) do
    expr == String.reverse(expr)
  end
end
