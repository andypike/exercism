defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t) :: String.t()
  def abbreviate(long_name) do
    long_name
    |> String.split
    |> Enum.map(&capitalize/1)
    |> Enum.map(&remove_lowercase_and_punctuation/1)
    |> Enum.join
  end

  defp capitalize(word) do
    String.upcase(String.first(word))
    <>
    String.slice(word, 1..-1)
  end

  defp remove_lowercase_and_punctuation(word) do
    String.replace(word, ~r/[a-z]+\W*/, "")
  end
end
