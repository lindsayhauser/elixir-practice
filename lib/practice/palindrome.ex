defmodule Practice.Palindrome do
  # Is the given string a palindrome
  def palindrome?(expr) when is_binary(expr) do
    String.downcase(expr) == String.reverse(String.downcase(expr))
  end
end
