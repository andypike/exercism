defmodule Words do
  import String, only: [downcase: 1, replace: 3, split: 1]
  import Enum, only: [reduce: 3]
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
    |> split_into_words
    |> count_words
  end

  defp split_into_words(sentence) do
    sentence
    |> downcase
    |> replace_underscores_with_spaces
    |> remove_invalid_characters
    |> split
  end

  defp replace_underscores_with_spaces(sentence) do
    replace(sentence, ~r/_/, " ")
  end

  defp remove_invalid_characters(sentence) do
    replace(sentence, ~r/[^\w\d\s-]/u, "")
  end

  defp count_words(words) do
    words
    |> reduce(%{}, &(Map.put(&2, &1, increment_count(&1, &2))))
  end

  defp increment_count(word, counts) do
    Map.get(counts, word, 0) + 1
  end
end
