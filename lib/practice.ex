defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # This is more complex, delegate to lib/practice/calc.ex
    # Practice.Calc.factor(x)
    # Maybe delegate this too.
    [1,9,x]
  end

  # TODO: Add a palindrome? function.
  def isPalindrome(x) do
    #This is complex, deligate it to calc.ex
    Practice.Calc.isPalindrome(x)
  end

end
