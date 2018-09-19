defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    expr
    |> String.split(" ")
    |> tagTokens([])
    |> postfixConversion([])
    |> evalStackCalculator([])
  end

  # References: https://www.geeksforgeeks.org/expression-evaluation/
  # Tag each token of the expression. For operators, assign a priority, where
  # multiplication and division come become addition and subtraction
  defp tagTokens(expression, acc) do
    case {expression, acc} do
      {[], acc} -> acc
      {_, acc} ->
        cond do
          hd(expression) === "+" -> tagTokens(tl(expression), [{:op, 1, "+"}] ++ acc)
          hd(expression) === "-" -> tagTokens(tl(expression), [{:op, 1, "-"}] ++ acc)
          hd(expression) === "*" -> tagTokens(tl(expression), [{:op, 2, "*"}] ++ acc)
          hd(expression) === "/" -> tagTokens(tl(expression), [{:op, 2, "/"}] ++ acc)
          true -> tagTokens(tl(expression), [{:num, hd(expression)}] ++ acc)
        end
    end
  end

  # References: http://condor.depaul.edu/ichu/csc415/notes/notes9/Infix.htm
  # http://csis.pace.edu/~wolf/CS122/infix-postfix.htm
  defp postfixConversion(tokens, stackAcc) do
    case {tokens, stackAcc} do
      {[], stackAcc} -> stackAcc
      # if it is a number, it goes to output and recursion is done on the rest
      # of the list
      {[{:num, _} | tailTokens], stackAcc} ->
        [hd(tokens)] ++ postfixConversion(tailTokens, stackAcc)

      # Operator cases.
      # If the operator on the top of the stack has higher precedence than the
      # one being read, pop and print the one on top until you find pop the
      # stack and find an op of lower priority & then call recursion
      {[{:op, priority, _} | tailTokens], stackAcc} ->
        cond do
          stackAcc == [] ->
            postfixConversion(tailTokens, [hd(tokens)] ++ stackAcc)
            # Priority of current token is higher, push onto stack
          priority >= elem(hd(stackAcc), 1) ->
            postfixConversion(tailTokens, [hd(tokens)] ++ stackAcc)
          # Current token has lower priority than the first on the stack.
          # Pop the stack and put it to output. Call recursion on the list
          # using the same tokens, since we want to keep popping the stack until
          # we find an op of lower priority
          true ->
            firstEl = hd(stackAcc)
            stackAcc = tl(stackAcc)
            [firstEl] ++ postfixConversion(tokens, stackAcc)
        end
    end
  end

  # References: http://condor.depaul.edu/ichu/csc415/notes/notes9/Infix.htm
  defp evalStackCalculator(tokens, stackAcc) do
     # Step through the expressions one token at a time
     # If it is a number, add it to stackAcc
     # If it is an operator, then pop stackAcc twice
     # Perform the operation, and push the result back on the stackAcc
     # At end of expression, the top of stack has answer
     case {tokens, stackAcc} do
       {[], stackAcc} -> String.to_integer(elem(hd(stackAcc), 1))
       {[{:num, val} | tailTokens], stackAcc} ->
         evalStackCalculator(tailTokens, [{:val, val}] ++ stackAcc)
        {[{:op, _, symbol} | tailTokens], stackAcc} ->
          firstEl = hd stackAcc
          stackAcc = tl stackAcc
          secondEl = hd stackAcc
          stackAcc = tl stackAcc

          firstNum = String.to_integer(elem(firstEl, 1))
          secondNum = String.to_integer(elem(secondEl, 1))
          val = evalulate(symbol, firstNum, secondNum)

          evalStackCalculator(tailTokens,
           [{:num, Integer.to_string(val)}] ++ stackAcc)
        end
  end

  # References: https://www.geeksforgeeks.org/expression-evaluation/
  defp evalulate(operator, num1, num2) do
    case operator do
      "/" -> div(num1, num2)
      "*" -> num1 * num2
      "-" -> num1 - num2
      "+" -> num1 + num2
    end
  end
end
