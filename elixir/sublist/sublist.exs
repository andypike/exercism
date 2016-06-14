defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], [_|_]), do: :sublist
  def compare([_|_], []), do: :superlist
  def compare([], []), do: :equal
  def compare(a, b) do
    cond do
      a == b         -> :equal
      sublist?(a, b) -> :sublist
      true           -> :unequal
    end
  end

  defp sublist?([], b), do: true
  defp sublist?([h|t], b) do
    exists = Enum.any?(b, fn(e) -> h == e end)

    cond do
      exists -> sublist?(t, b)
      true   -> false
    end
  end
end
