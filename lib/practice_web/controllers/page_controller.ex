defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    n = String.to_integer(x)
    y = inspect(Practice.factor(n));
    render conn, "factor.html", x: n, y: y
  end

  # Action for palindrome.
  # Added page in lib/practice_web/templates/page/palindrome.html.eex
  def palindrome(conn, %{"x" => x}) do
    y = Practice.palindrome?(x)
    render conn, "palindrome.html", x: x, y: y
  end

end
