defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t) :: String.t()
  def abbreviate(long_name) do
    long_name
    |> String.split
    |> Enum.map(&(String.first(&1)))
    |> Enum.join
  end
end
