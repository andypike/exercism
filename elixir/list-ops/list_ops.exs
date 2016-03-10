defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_ | tail]) do
    1 + count(tail)
  end

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc
  defp do_reverse([head | tail], acc), do: do_reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map(l, f) do
    for n <- l, do: f.(n)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter(l, f) do
    for n <- l, f.(n), do: n
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, f) do
    acc = f.(head, acc)
    reduce(tail, acc, f)
  end

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], b), do: b
  def append(a, []), do: a
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do

  end
end
