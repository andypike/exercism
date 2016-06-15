defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], [_|_]), do: :sublist
  def compare([_|_], []), do: :superlist
  def compare([], []), do: :equal
  def compare(a, b) when a === b, do: :equal
  def compare(a, b) do
    cond do
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true           -> :unequal
    end
  end

  defp sublist?(a, b) when length(a) > length(b), do: false
  defp sublist?(a, [h|t]) do
    start = Enum.take([h|t], length(a))

    cond do
      a === start -> true
      true        -> sublist?(a, t)
    end
  end
end
